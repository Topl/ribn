import { API_METHODS } from "../utils/configs";
import { Messenger } from "./messenger";

export const signTx = async (rawTx: any) => {
	try {
		const result = await Messenger.forwardToContentScript({
			method: API_METHODS.signTx,
			data: rawTx,
		});
		return result.data;
	} catch (err) {
		return err;
	}
};

export const enable = async () => {
	try {
		const result = await Messenger.forwardToContentScript({
			method: API_METHODS.enable,
		});
		return result.data;
	} catch (err) {
		return err;
	}
};

export const isEnabled = async () => {
	try {
		const result = await Messenger.forwardToContentScript({
			method: API_METHODS.isEnabled,
		});
		return result.data;
	} catch (err) {
		return err;
	}
};
