export const TOPL_URLS = ['https://annulus.topl.services', 'https://lattice.topl.services'];

export const API_METHODS = {
    enable: "enable",
    signTx: "signTx",
    isEnabled: "isEnabled",

    //v2
    authorize: "authorize",
    getBalance: "getBalance",
    signTransaction: "signTransaction",
    revoke: "revoke",
};


export const INTERNAL_METHODS = {
    checkPendingRequest: "checkPendingRequest",
    returnResponse: "returnResponse",
    clearList: "clearList"
};

export const TARGET = "topl-ribn-wallet";

export const SENDERS = {
    webpage: "webpage",
    ribn: "ribn",
};

export const API_ERRORS = {
    internalError: "Internal error",
    refused: "Connection refused",
    invalidRequest: "Invalid request",
    accessDenied: "Access denied",
};

export const POPUP = {
    width: 500,
    height: 500,
    top: 50,
    left: 100,
};