/* eslint-disable no-unused-vars */

/**
 * Persists data to local storage
 * @param {number} obj the data to be persisted
 * @returns {void}
 */
async function persistToStorage(obj) {
  await chrome.storage.local.set({data: obj});
}

/**
 * Get's data from local storage
 * @returns {string} the fetched data
 */
async function fetchData() {
  const result = await getDataFromLocalStorage("data");
  if (!result) {
    return "{}";
  }
  return result;
}

/**
 * A wrapper function to fetch data from local storage and return a promise
 * @param {string} key the object keys
 * @returns {Promise} A resolved promise with the requested data or a rejected promise in case of runtime error
 */
function getDataFromLocalStorage(key) {
  return new Promise(function(resolve, reject) {
    chrome.storage.local.get(key, function(items) {
      if (chrome.runtime.lastError) {
        console.error(chrome.runtime.lastError.message);
        reject(chrome.runtime.lastError.message);
      } else {
        resolve(items[key]);
      }
    });
  });
}

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

