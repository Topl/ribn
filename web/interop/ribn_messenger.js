
var ribn_messenger = function () {
    /**
     * @type {chrome.runtime.Port}
     */
    let port;

    return {
        openConnection: () => {
            try {
                port = chrome.runtime.connect(chrome.runtime.id, { name: "ribn-bg" });
            } catch (e) {
                console.error(e);
            }
        },
        /**
         * Sends `msg` to the background script.
         * 
         * @param {string} msg 
         */
        sendPortMessage: (msg) => {
            try {
                port.postMessage(msg);
            } catch (e) {
                console.error(e);
            }
        },
        /**
         * @param {(arg0: any) => void} fn - Callback function 
         */
        addPortMessageListener: (fn) => {
            port.onMessage.addListener(function messageHandler(/** @type {any} */ msg) {
                port.onMessage.removeListener(messageHandler);
                fn(msg);
            });
        },
    };
}();