
var ribn_messenger = function () {
    let port;
    return {
        openConnection: () => {
            try {
                port = chrome.runtime.connect({ name: "ribn-bg" });
            } catch (e) {
                console.error(e);
            }
        },
        sendPortMessage: () => {
            try {
                port.postMessage(msg);
            } catch (e) {
                console.error(e);
            }
        },
        addPortMessageListener: (fn) => {
            port.onMessage.addListener(function messageHandler(msg) {
                port.onMessage.removeListener(messageHandler);
                fn(msg);
            });
        },
    };
}();