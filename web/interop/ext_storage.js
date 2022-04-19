var ext_storage = {
    /**
    * Uses the `chrome.storage` api to get data from extension's local storage.
    * 
    * @returns Promise that resolves with all items in local storage.
    */
    getFromLocalStorage: () => {
        return new Promise((resolve, reject) => {
            console.log("Attempting to get from local storage");
            // `null` gets everything in local storage
            chrome.storage.local.get(null, function (items) {
                if (chrome.runtime.lastError) {
                    console.error(chrome.runtime.lastError.message);
                    reject(chrome.runtime.lastError.message);
                } else {
                    resolve(items);
                }
            });
        });
    },

    /**
    * Updates the extension's local storage with `obj`.
    */
    persistToLocalStorage: async (obj) => {
        const parsedObj = JSON.parse(obj);
        const stored = await this.getFromLocalStorage();
        await chrome.storage.local.set({
            ...stored,
            ...parsedObj,
        });
    },

    /**
     * Get's data from the extension's local storage and returns a stringified version of it.
     * 
     * @returns {string} Stringified json of locally stored data.
     */
    getFromLocalStorageStringified: async () => {
        const result = await this.getFromLocalStorage();
        if (!result) {
            return "{}";
        }
        const stringifiedJson = JSON.stringify(result);
        return stringifiedJson;
    }

}