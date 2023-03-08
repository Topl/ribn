import {isEnabled, getBalance, authorize, signTransaction, revoke} from "../api/webpage";

window["topl"] = {
    //v1
	isEnabled: () => isEnabled(),

	//v2
	authorize: (name: string, icon: string) => authorize(name, icon),
	getBalance: () => getBalance(),
	signTransaction: (rawTx: any) => signTransaction(rawTx),
	revoke: () => revoke(),


};
