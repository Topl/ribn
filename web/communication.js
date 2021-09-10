// The code below has been used for testing connection between the popup and the background script
// None of it is currently in use, it is kept for future purposes
let port;

/**
 * Sends message to any script that's listening
 * This function is not currently in use
 * @returns {void}
 */
function sendMessage() {
  chrome.runtime.sendMessage({message: "get_color"}, (res) => {
    console.log("Response: " + res);
  });
}


/**
 * Initiates a long-lived connection with background.js
 * This function is not currently in use
 * @returns {void}
 */
function connectToBackground() {
  port = chrome.runtime.connect({name: "background-script"});
  console.log(port);
}


/**
 * Adds a listener for incoming messages
 * This function is f currently in use
 * @param {function} fn A message handler function
 * @returns {void}
 */
function addMessageListener(fn) {
  port.onMessage.addListener(function(msg) {
    fn(msg);
  });
}

/**
 * Sends a message to the connection held by port
 * This function is not currently in use
 * @param {any} msg message to send
 * @returns {void}
 */
function sendPortMessage(msg) {
  port.postMessage(msg);
}

