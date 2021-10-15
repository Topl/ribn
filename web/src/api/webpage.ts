import { API_METHODS } from "../utils/configs";
import { Messenger } from "./messenger";

export const signTx = async (rawTx: any) => {
	const result = await Messenger.forwardToContentScript({
		method: API_METHODS.signTx,
		data: rawTx,
	});
	return result.data;
};

export const enable = async () => {
	const result = await Messenger.forwardToContentScript({
		method: API_METHODS.enable,
	});
	return result.data;
};

export const isEnabled = async () => {
	const result = await Messenger.forwardToContentScript({
		method: API_METHODS.isEnabled,
	});
	return result.data;
};
