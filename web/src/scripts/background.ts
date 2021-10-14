import { Messenger } from "../api/messenger";

/**
 * Event fired upon initial installation of the extension
 */
chrome.runtime.onInstalled.addListener((details: chrome.runtime.InstalledDetails) => {
	console.log("Extension installed:", details);
});

/**
 * Respond to action click if manifest.json has not specified a
 * default default_popup.
 * Ref: https://developer.chrome.com/docs/extensions/reference/action/#popup
 */
chrome.action.onClicked.addListener((tab: chrome.tabs.Tab) => {
	console.log(tab);
});

const messenger = Messenger.createBackgroundMessagingController();
messenger.initListener();
