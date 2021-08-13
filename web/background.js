// Event fired upon initial installation of the extension
chrome.runtime.onInstalled.addListener(() => {
  console.log("Extension installed!");
  // chrome.tabs.create({ url: "index.html" });
});

// The action.onClicked event will not be dispatched
// if the extension action has specified a popup to show on click
// on the current tab.
// ref: https://developer.chrome.com/docs/extensions/reference/action/#popup
chrome.action.onClicked.addListener((tab) => {
  console.log("Action clicked");
  console.log(tab);
});
