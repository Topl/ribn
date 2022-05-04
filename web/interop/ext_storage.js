var ext_storage = {
    /**
    * Uses the `chrome.storage` api to get data from extension's local storage.
    * 
    * @returns Promise that resolves with all items in local storage.
    */
    getFromLocalStorage: () => {
        return new Promise((resolve, reject) => {
            // `undefined` gets everything from local storage
            chrome.storage.local.get(undefined, function (items) {
                // @ts-ignore
                if (chrome.runtime.lastError) reject(chrome.runtime.lastError.message);
                resolve(items);
            });
        });
    },

    /**
    * Updates the extension's local storage with `obj`.
    * @param {string} obj - Stringified json of data to persist.
    */
    persistToLocalStorage: async (obj) => {
        const parsedObj = JSON.parse(obj);
        const stored = await ext_storage.getFromLocalStorage();
        await chrome.storage.local.set({
            ...stored,
            ...parsedObj,
        });
    },

    /**
     * Get's data from the extension's local storage and returns a stringified version of it.
     * 
     * @returns Stringified json of locally stored data.
     */
    getFromLocalStorageStringified: async () => {
        const result = await ext_storage.getFromLocalStorage();
        if (!result) {
            return "{}";
        }
        const stringifiedJson = JSON.stringify(result);
        return stringifiedJson;
    },
};