import {enable, signTx, isEnabled, getBalance, authorize, signTransaction, revoke} from "../api/webpage";

window["topl"] = {
	enable: () => enable(),
	isEnabled: () => isEnabled(),
	signTx: (rawTx: any) => signTx(rawTx),

	//v2
	authorize: (name: string, icon: string) => authorize(name, icon),
	getBalance: () => getBalance(),
	signTransaction: (rawTx: any) => signTransaction(rawTx),

	revoke: () => revoke(),

};
