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
                const stringifiedResult = JSON.stringify(items);
                resolve(stringifiedResult);
            });
        });
    },

    /**
    * Updates the extension's local storage with `obj`.
    * @param {string} obj - Stringified json of data to persist.
    */
    persistToLocalStorage: async (obj) => {
        const parsedObj = JSON.parse(obj);
        const stored = JSON.parse(await ext_storage.getFromLocalStorage());
        await chrome.storage.local.set({
            ...stored,
            ...parsedObj,
        });
    },

    /**
     * Uses the `chrome.storage` api to get data from extension's session storage.
     * 
     * @returns Promise that resolves with all items stored in the extension's in-memory cache.
     */
    getFromSessionStorage: () => {
        return new Promise((resolve, reject) => {
            chrome.storage.session.get(undefined, function (items) {
                // @ts-ignore
                if (chrome.runtime.lastError) reject(chrome.runtime.lastError.message);
                const stringifiedResult = JSON.stringify(items);
                resolve(stringifiedResult);
            });
        });
    },

    /**
     * Updates the extension's in-memory cache with `obj`.
     * 
     * @param {string} obj - Stringified json of data to save.
     */
    saveToSessionStorage: async (obj) => {
        const parsedObj = JSON.parse(obj);
        const stored = JSON.parse(await ext_storage.getFromSessionStorage());
        await chrome.storage.session.set({
            ...stored,
            ...parsedObj,
        });
    }
};