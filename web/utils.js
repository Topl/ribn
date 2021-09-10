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