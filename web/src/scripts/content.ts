import { Messenger } from "../api/messenger";

/**
 * Injects `injected.js` script into the current web-page's DOM to provide API access.
 */
// QQQQ injects here
function injectScript(): void {
    try {
        const script = document.createElement("script");
        script.async = false;
        script.src = chrome.runtime.getURL("./dist/injected.bundle.js");
        script.onload = function () {
            script.remove();
        };
        (document.head || document.documentElement).appendChild(script);
    } catch (e) {
        console.error("Topl: API injection failed");
    }
}

injectScript();
console.log('QQQQ injects here');
const messenger = Messenger.createContentMessagingController();
messenger.initListeners();
