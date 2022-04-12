
// var messenger = function () {
//     let port;
//     return {
//         connectToBackground: () => {
//             console.log("Attempting to connect to background");
//             try {
//                 port = chrome.runtime.connect({ name: "ribn-bg" });
//             } catch (e) {
//                 console.error(e);
//             }
//         },
//         sendPortMessage: () => {
//             console.log("Sending port Message");
//         },
//         addPortMessageListener: (fn) => {
//             port.onMessage.addListener(function messageHandler(msg) {
//                 port.onMessage.removeListener(messageHandler);
//                 fn(msg);
//             });
//         },
//         sendPortMessage: (msg) => {
//             port.postMessage(msg);
//         }
//     };
// }();

class Messenger {
    constructor() {
        console.log("CONSTRUCTING MESSENGER");
     }

    connectToBackground() {
        console.log("Attempting to connect to background");
        this.port = 'AYOOO';
        console.log(this.port);
        try {
            this.port = chrome.runtime.connect({ name: "ribn-bg" });
        } catch (e) {
            console.error(e);
        }
    };

    sendPortMessage(msg) {
        console.log("Sending port Message");
    }

    addPortMessageListener(fn) {
        port.onMessage.addListener(function messageHandler(msg) {
            port.onMessage.removeListener(messageHandler);
            fn(msg);
        });
    }

    sendPortMessage(msg) {
        port.postMessage(msg);
    }
}

window.Messenger = Messenger;