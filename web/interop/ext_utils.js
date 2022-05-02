
var ext_utils = {
    getAppVersion: () => {
        try {
            return chrome.runtime.getManifest().version;
        } catch (e) {
            return 'Dev';
        }
    },
    deleteWallet: () => {
        chrome.storage.local.clear(function () {
            window.close();
        });
    },
    downloadAsFile: (filename, text) => {
        var element = document.createElement('a');
        element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
        element.setAttribute('download', filename);
        element.style.display = 'none';
        document.body.appendChild(element);
        element.click();
        document.body.removeChild(element);
    },
    openAppInNewTab: async () => {
        await chrome.tabs.create({ url: chrome.runtime.getURL("index.html"), active: true });
    },
    getCurrentView: async () => {
        try {
            const currentTab = await chrome.tabs.getCurrent();
            if (currentTab == undefined) {
                return 'extension'
            }
            else if (currentTab.id > 0) {
                return 'tab'
            }
        } catch (e) {
            return 'debug';
        }
    }
};