import { INPAGE_METHODS } from "../utils/configs";
import { Messenger } from "./messenger";

export const signTx = async (rawTx: any) => {
	console.log("forwarding to content-script...");
	const result = await Messenger.forwardToContentScript({
		method: INPAGE_METHODS.signTx,
		data: rawTx,
	});
	return result.data;
};

export const enable = async () => {
	const result = await Messenger.forwardToContentScript({
		method: INPAGE_METHODS.enable,
	});
	return result.data;
};
