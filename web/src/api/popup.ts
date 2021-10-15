import { POPUP } from "../utils/configs";

/**
 * Opens the extension in a new popup window.
 *
 * @returns information about the newly created tab
 */
export const createPopup = (): Promise<chrome.tabs.Tab> => {
	return new Promise((resolve) =>
		chrome.tabs.create(
			{
				url: chrome.runtime.getURL("index.html"),
				active: false,
			},
			function (tab) {
				chrome.windows.create(
					{
						tabId: tab.id,
						type: "popup",
						focused: true,
						width: POPUP.width,
						height: POPUP.height,
						top: POPUP.top,
						left: POPUP.left,
					},
					function () {
						resolve(tab);
					}
				);
			}
		)
	);
};
