import { Messenger } from "../api/messenger";

const messenger = Messenger.createBackgroundMessagingController();
messenger.initListener();

// Clear session storage upon alarm event with name 'loginSession'
chrome.alarms.onAlarm.addListener((alarm) => {
	if (alarm.name == 'loginSession') chrome.storage.session.clear();
});