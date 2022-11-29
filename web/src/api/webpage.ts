import {API_METHODS} from "../utils/configs";
import {Messenger} from "./messenger";

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

//v2

export const authorize = async (name: string, icon: string) => {
    try {
        const result = await Messenger.forwardToContentScript({
            method: API_METHODS.authorize,
            data: {name: name, url: icon}
        });
        return result.data;
    } catch (err) {
        return err;
    }
};

export const getBalance = async () => {
    try {
        const result = await Messenger.forwardToContentScript({
            method: API_METHODS.getBalance,
        });
        return result.data;
    } catch (err) {
        return err;
    }
};

export const signTransaction = async (rawTx: any) => {
    try {
        const result = await Messenger.forwardToContentScript({
            method: API_METHODS.signTransaction,
            data: rawTx,
        });
        return result.data;
    } catch (err) {
        return err;
    }
};

export const revoke = async () => {
    try {
        const result = await Messenger.forwardToContentScript({
            method: API_METHODS.revoke,
        });
        return result.data;
    } catch (err) {
        return err;
    }
};



