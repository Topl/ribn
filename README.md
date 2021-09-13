# Ribn

## Description
A lightweight flutter wallet to interact with the Topl blockchain.

## Prerequisites
* Flutter (v2.6.0-1.0.pre.136)
* Dart (v2.15.0-66.0.dev)
* Your preferred code editor 
* Node v16.6.2
* Npm


## Project Setup

#### Flutter installation:
* Follow instructions from Flutter's official docs for installation on your platform: https://flutter.dev/docs/get-started/install
* Confirm that flutter has been installed on your system by entering the following commands:
```
which flutter
flutter doctor 
```

#### NodeJS Version (NVM)
* This application will likely be using a specific NodeJS version. In order to develop locally, ensure that the correct node version is running using NVM. There is a .nvmrc file in the project root. With NVM installed, enter the following command:
```
nvm use
```


#### Launch
Once you have flutter set up:
* Clone this repo
* Navigate to the cloned repo in your code editor / IDE
* If your editor does not automatically install all dependencies, run the following command:
```
flutter pub get
```
* Run the following command to build the chrome extension:
```
flutter build web --web-renderer html --csp
```
* Open Google Chrome
* To load the extension in your browser, please follow the instructions listed <a href="https://developer.chrome.com/docs/extensions/mv3/getstarted/#:~:text=Open%20the%20Extension%20Management%20page%20by%20navigating%20to">here</a>:  
* Once you have loaded the unpacked extension, you should be able to open it.
