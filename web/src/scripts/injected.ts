import { enable, signTx, isEnabled } from "../api/webpage";

// Reference: https://github.com/cardano-foundation/CIPs/pull/88
window["topl"] = {
	enable: () => enable(),
	isEnabled: () => isEnabled(),
	signTx: (rawTx: any) => signTx(rawTx),
};
