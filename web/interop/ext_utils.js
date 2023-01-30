var ext_utils = {
	logToConsole: (/** @type {any} */ dynamic) => {
		console.log(dynamic);
	},

	getALlowedString: () => {
		return "";
	},
	getAppVersion: () => {
		try {
			return chrome.runtime.getManifest().version;
		} catch (e) {
			return "Dev";
		}
	},
	deleteWallet: () => {
		chrome.storage.local.clear(function () {
			window.close();
		});
	},
	/**
	 * Clears AllowList
	 */
	deleteAllowList: async () => {
		await chrome.storage.local.set({ 'allowList': [] });
	},
	/**
	 * Gets full AllowList
	 */
	retrieveAllowList: async () => {
		let storage = await chrome.storage.local.get(undefined);
		storage = storage ? storage.allowList : [];
		return (storage);
	},
	/**
	 *
	 * Downloads a new file with name as `filename` and content as `text`.
	 *
	 * @param {string} filename
	 * @param {string} text
	 */
	downloadAsFile: (filename, text) => {
		var element = document.createElement("a");
		element.setAttribute("href", "data:text/plain;charset=utf-8," + encodeURIComponent(text));
		element.setAttribute("download", filename);
		element.style.display = "none";
		document.body.appendChild(element);
		element.click();
		document.body.removeChild(element);
	},
	openAppInNewTab: async () => {
		await chrome.tabs.create({ url: chrome.runtime.getURL("index.html"), active: true });
	},
	getCurrentView: async () => {
		try {
			const currentTab = await chrome.tabs.getCurrent();
			if (currentTab == undefined) {
				return "extension";
			} else if (currentTab.id) {
				return "tab";
			}
			return "invalid";
		} catch (e) {
			return "debug";
		}
	},
	/**
	 * Creates a new alarm to trigger 60 minutes from now.
	 */
	createSessionAlarm: () => {
		chrome.alarms.create("loginSession", { delayInMinutes: 60 });
	},
};
