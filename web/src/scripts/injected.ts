import { enable, signTx, isEnabled } from "../api/webpage";

window["topl"] = {
	enable: () => enable(),
	isEnabled: () => isEnabled(),
	signTx: (rawTx: any) => signTx(rawTx),
};
