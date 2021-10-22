import { Messenger } from "../api/messenger";
import { ExtensionStorage } from "../api/storage";

/**
 * Event fired upon initial installation of the extension
 */
chrome.runtime.onInstalled.addListener((details: chrome.runtime.InstalledDetails) => {
	console.log("Extension installed:", details);
});

/**
 * Opens a new tab if onboarding, otherwise sets the extension popup.
 */
chrome.action.onClicked.addListener(async (tab: chrome.tabs.Tab) => {
	const storage = await ExtensionStorage.getStorage();
	if (!storage || !storage["keychainState"] || !storage["keychainState"]["keyStoreJson"]) {
		chrome.tabs.create({ url: chrome.runtime.getURL("index.html"), active: true });
	} else {
		chrome.action.setPopup({ popup: chrome.runtime.getURL("index.html") });
	}
	console.log(tab);
});

const messenger = Messenger.createBackgroundMessagingController();
messenger.initListener();
