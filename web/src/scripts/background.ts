import { Messenger } from "../api/messenger";
// import { ExtensionStorage } from "../api/storage";

/**
 * Event fired upon initial installation of the extension
 */
chrome.runtime.onInstalled.addListener((details: chrome.runtime.InstalledDetails) => {
	console.log("Extension installed:", details);
});

const messenger = Messenger.createBackgroundMessagingController();
messenger.initListener();
