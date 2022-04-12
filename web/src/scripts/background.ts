import { Messenger } from "../api/messenger";
import { ExtensionStorage } from "../api/storage";
import { TOPL_URLS } from "../utils/configs";

/**
 * Event fired upon initial installation of the extension
 */
chrome.runtime.onInstalled.addListener(async () => {
	for (const url of TOPL_URLS){
		await ExtensionStorage.addToAllowList(url);
	}
});
const messenger = Messenger.createBackgroundMessagingController();
messenger.initListener();
