import { API_ERRORS, API_METHODS, INTERNAL_METHODS, SENDERS, TARGET } from "../utils/configs";
import { APIRequest, InternalMessage } from "../utils/types";
import { createPopup } from "./popup";
import { ExtensionStorage } from "./storage";


export const Messenger = {
    /**
     * Forwards request from the web-page to the content-script.
     * Attaches a listener to listen for response from the content-script.
     */
    forwardToContentScript: ({ method, data }: APIRequest): Promise<InternalMessage> => {
        console.log("QQQQ 1");
        return new Promise((resolve, reject) => {
            const requestId: string = Math.random().toString(36).substr(2);
            // listen for message-events from the content-script
            window.addEventListener("message", function responseHandler(result) {
                const response: InternalMessage = result.data;
                if (
                    typeof response !== "object" ||
                    response === null ||
                    !response.target ||
                    response.target !== TARGET ||
                    !response.id ||
                    response.id !== requestId ||
                    !response.sender ||
                    response.sender !== SENDERS.ribn
                )
                    return;
                window.removeEventListener("message", responseHandler);
                if (response.error) reject(response.error);
                else resolve(response);
            });
            // post message to the content-script
            window.postMessage(
                {
                    method,
                    data,
                    target: TARGET,
                    sender: SENDERS.webpage,
                    id: requestId,
                },
                window.origin
            );
        });
    },
    createBackgroundMessagingController: () => new BackgroundMessenger(),
    createContentMessagingController: () => new ContentMessenger(),
};

/**
 * Content Messenger
 */
class ContentMessenger {
    public forwardToBackground = (request: InternalMessage) => {
        return new Promise<InternalMessage>((resolve) =>
            chrome.runtime.sendMessage(request, {}, (response) => {
                resolve(response);
            })
        );
    };
    /**
     * Initializes a `chrome.runtime.onMessage` listener to listen for messages sent from the background script.
     * In addition, also initializes a message-event listener on the `window` to listen for messages sent form the web-page.
     *
     * The primary purpose here is to relay messages between the web-page and the extension.
     */
    public initListeners = () => {
        chrome.runtime.onMessage.addListener((message: InternalMessage) => {
            console.log("QQQQ 2");

            if (
                typeof message !== "object" ||
                message === null ||
                !message.target ||
                message.target !== TARGET ||
                !message.sender ||
                message.sender !== SENDERS.ribn ||
                !message.event
            )
                return;
            window.postMessage(message);
            return true;
        });
        // listen to calls from webpage
        window.addEventListener("message", async (msg) => {
            const request: InternalMessage = msg.data;
            if (
                typeof request !== "object" ||
                request === null ||
                !request.method ||
                !request.target ||
                request.target !== TARGET ||
                !request.sender ||
                request.sender !== SENDERS.webpage
            )
                return;
            request.origin = window.origin;
            const isEnabledResponse: InternalMessage = await this.forwardToBackground({
                ...request,
                method: API_METHODS.isEnabled,
            });
            const isOriginAllowed = (isEnabledResponse.data as Record<string, any>)["enabled"];
            const permissionRequired = ![API_METHODS.isEnabled, API_METHODS.authorize].includes(request.method);

            if (request.method == API_METHODS.isEnabled) {
                window.postMessage(isEnabledResponse);
            } else if (!isOriginAllowed && permissionRequired) {
                window.postMessage({
                    ...request,
                    sender: SENDERS.ribn,
                    error: {
                        message: API_ERRORS.accessDenied,
                    },
                });
            } else {
                this.forwardToBackground(request).then((response) => {
                    window.postMessage(response);
                });
            }
        });
    };
}

/**
 * BackgroundMessenger
 */
class BackgroundMessenger {

    /** Responders for all the API methods available to web-pages.*/
    public responders = {
        isEnabled: (request: InternalMessage, sendResponse: (response?: InternalMessage) => void) => {
            ExtensionStorage.isOriginAllowed(request.origin as string).then((isAllowed) => {
                sendResponse({
                    ...request,
                    sender: SENDERS.ribn,
                    data: {
                        enabled: isAllowed,
                    },
                });
            });
        },
        //v2
        authorize: (request: InternalMessage, sendResponse: (response?: InternalMessage) => void) => {
            console.log('QQQQ authorize');
            ExtensionStorage.isOriginAllowed(request.origin as string).then((isAllowed) => {
                if (!isAllowed) {
                    request.additionalNavigation = "/connect-dapp"
                    createPopup()
                        .then((tab) => this.handlePopupConnection(request, tab))
                        .then(async (result) => {
                            if (result.data && result.data["enabled"] == true) {
                                await ExtensionStorage.addToAllowList(request.origin as string);
                            }
                            result.additionalNavigation = "/connect-dapp"
                            sendResponse(result);
                        });
                } else {
                    sendResponse({
                        ...request,
                        sender: SENDERS.ribn,
                        data: {
                            walletAddress: "",
                            enabled: isAllowed,

                        },
                    });
                }
            });
        },
        getBalance: (request: InternalMessage, sendResponse: (response?: InternalMessage) => void) => {
            createPopup()
                .then((tab: chrome.tabs.Tab) => this.handlePopupConnection(request, tab))
                .then((result) => {
                    sendResponse(result);
                });
            sendResponse({
                ...request,
                sender: SENDERS.ribn,
                data: {
                    //                     message: window.randomFunctionName(),
                    message: "",
                }
            });
        },
        signTransaction: async (request: InternalMessage, sendResponse: (response?: InternalMessage) => void) => {
            createPopup()
                .then((tab: chrome.tabs.Tab) => this.handlePopupConnection(request, tab))
                .then((result) => {
                    sendResponse(result);
                });
        },
        revoke: async (request: InternalMessage, sendResponse: (response?: InternalMessage) => void) => {
            await ExtensionStorage.removeFromAllowList(request.origin as string);
            sendResponse({
                ...request,
                sender: SENDERS.ribn,
                data: {
                    message: "permissions revoked",
                }
            });
        },
        clearList: async (request: InternalMessage, sendResponse: (response?: InternalMessage) => void) => {
            await ExtensionStorage.clearAllowList();
            sendResponse({
                ...request,
                sender: SENDERS.ribn,
                data: {
                    message: "All permissions revoked",
                }
            });
        },
    };

    /**
     * Opens a long-lived connection port with the popup and attaches listeners.
     */
    public handlePopupConnection = (request: InternalMessage, tab: chrome.tabs.Tab): Promise<InternalMessage> => {
        return new Promise((resolve) => {
            chrome.runtime.onConnect.addListener(function popupConnectionHandler(port: chrome.runtime.Port) {
                port.onMessage.addListener(function popupMessageHandler(msg: string) {
                    const parsedMsg = JSON.parse(msg);
                    if (parsedMsg.method == INTERNAL_METHODS.checkPendingRequest) {
                        port.postMessage(JSON.stringify(request));
                    } else if (parsedMsg.method == INTERNAL_METHODS.returnResponse) {
                        resolve(parsedMsg);
                        if (tab.id) chrome.tabs.remove(tab.id);
                    }
                    // If the user closed window, remove listeners
                    chrome.tabs.onRemoved.addListener(function popupTabsHandler(tabId: number) {
                        if (tab.id !== tabId) return;
                        resolve({
                            ...request,
                            id: request.id,
                            target: TARGET,
                            sender: SENDERS.ribn,
                            error: {
                                message: API_ERRORS.refused,
                            },
                        });
                        chrome.runtime.onConnect.removeListener(popupConnectionHandler);
                        port.onMessage.removeListener(popupMessageHandler);
                        chrome.tabs.onRemoved.removeListener(popupTabsHandler);
                    });
                });
            });
        });
    };

    /**
     * Initializes a listener for one-time messages and responds according to the `request.method` specified.
     * This listener can receive messages from an external source or the extension popup.
     *
     * It is primarily used to respond to API calls from external web-pages.
     *
     * Notes:
     * - The callback for `chrome.runtime.onMessage.addListener` must `return true` in order for async message-passing to work.
     * - This listener does not recognize `async/await` keywords.
     */
    public initListener = () => {
        chrome.runtime.onMessage.addListener((request: InternalMessage, _, sendResponse: (response?: InternalMessage) => void) => {
            if (request.sender !== SENDERS.webpage) sendResponse({
                ...request,
                error: {
                    message: API_ERRORS.refused,
                },
            });
            switch (request.method) {
                case API_METHODS.isEnabled: {
                    this.responders.isEnabled(request, sendResponse);
                    break;
                }
                // v2
                case API_METHODS.authorize: {
                    request.additionalNavigation = ""
                    this.responders.authorize(request, sendResponse);
                    break;
                }
                case API_METHODS.getBalance: {
                    this.responders.getBalance(request, sendResponse);
                    break;
                }
                case API_METHODS.signTransaction: {
                    this.responders.signTransaction(request, sendResponse);
                    break;
                }
                case API_METHODS.revoke: {
                    this.responders.revoke(request, sendResponse);
                    break;
                }
                default: {
                    sendResponse({
                        ...request,
                        error: {
                            message: API_ERRORS.invalidRequest,
                        }
                    });
                }
            }
            return true;
        });
    };
}
