import { API_ERRORS } from "../utils/configs";

export const ExtensionStorage = {
	addToAllowList: async (url: string) => {
		const currentAllowList: string[] = await ExtensionStorage.getAllowList();
		if (!currentAllowList.includes(url)) {
			currentAllowList.push(url);
			await ExtensionStorage.setStorage("allowList", currentAllowList);
		}
	},
	getAllowList: async (): Promise<string[]> => {
		const storage = await ExtensionStorage.getStorage();
		return storage["allowList"] ? storage["allowList"] : [];
	},
	getStorage: () => {
		return new Promise<Record<string, any>>((resolve, reject) => {
			chrome.storage.local.get(null, (items) => {
				if (chrome.runtime.lastError) reject(API_ERRORS.internalError);
				resolve(items);
			});
		});
	},
	setStorage: async (key: string, val: any) => {
		const storage = await ExtensionStorage.getStorage();
		storage[key] = val;
		await chrome.storage.local.set({...storage });
	},
	
	isOriginAllowed: async (originUrl: string) => {
		const currentAllowList: string[] = await ExtensionStorage.getAllowList();
		return currentAllowList.some((allowedUrl) => allowedUrl.includes(originUrl));
	},
};
