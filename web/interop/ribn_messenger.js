
var ribn_messenger = function () {
    /**
     * @type {chrome.runtime.Port}
     */
    let port;

    return {
        openConnection: () => {
            try {
                console.log("QQQQ openConnection");
                port = chrome.runtime.connect(chrome.runtime.id, { name: "ribn-bg" });
            } catch (e) {
                console.log("QQQQ openConnection error", e);
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
                console.log("QQQQ sendPortMessage", msg);
                port.postMessage(msg);
            } catch (e) {
                console.log("QQQQ sendPortMessage error", e);
                console.error(e);
            }
        },
        /**
         * @param {(arg0: any) => void} fn - Callback function 
         */
        addPortMessageListener: (fn) => {
            try {
                console.log("QQQQ addPortMessageListener 1", port);
                port.onMessage.addListener(function messageHandler(/** @type {any} */ msg) {
                    port.onMessage.removeListener(messageHandler);
                    fn(msg);
                });
            } catch (e) {
                console.log("QQQQ addPortMessageListener error", e);
                console.error(e);
            }

        },
    };
}();