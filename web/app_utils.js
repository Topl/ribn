/**
 * Persists data to local storage
 * @param {number} obj the data to be persisted
 */
async function persistToStorage(obj) {
	const parsedObj = JSON.parse(obj);
	await chrome.storage.local.set({ data: parsedObj });
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
	const stringifiedJson = JSON.stringify(result);
	return stringifiedJson;
}

/**
 * A wrapper function to fetch data from local storage and return a promise
 * @param {string} key the object keys
 * @returns {Promise} A resolved promise with the requested data or a rejected promise in case of runtime error
 */
function getDataFromLocalStorage(key) {
	return new Promise(function (resolve, reject) {
		chrome.storage.local.get(key, function (items) {
			if (chrome.runtime.lastError) {
				console.error(chrome.runtime.lastError.message);
				reject(chrome.runtime.lastError.message);
			} else {
				resolve(items[key]);
			}
		});
	});
}

let port;

/**
 * Initiates a long-lived connection with the background script
 */
function connectToBackground() {
	port = chrome.runtime.connect({ name: "ribn-bg" });
}

/**
 * Attaches a listener for incoming messages from the connection held by `port`
 * @param {Function} fn callback function
 */
function addMessageListener(fn) {
	port.onMessage.addListener(function messageHandler(msg) {
		port.onMessage.removeListener(messageHandler);
		fn(msg);
	});
}

/**
 * Sends a message to the connection held by `port`
 * @param {any} msg: - message to send
 */
function sendPortMessage(msg) {
	port.postMessage(msg);
}

/**
 * Checks if the extension is opened in an extension-popup view or a new window.
 */
async function isExtensionView() {
	return (await chrome.tabs.getCurrent()) === undefined;
}