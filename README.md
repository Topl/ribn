# Ribn

## Description
A lightweight web wallet to interact with the Topl blockchain.

Ribn allows users to:
- View their Poly balance and assets held by the wallet
- Mint assets to their own or to another wallet
- Transfer Polys and assets
- Connect their wallet with dApps and sign transactions

## Build locally 
* Ensure you have [Node.js](https://nodejs.org) v16 installed. 
    * Recommended: If you are using nvm, you can run `nvm use` to install the right Node version.
* Ensure you have [Flutter](https://docs.flutter.dev/get-started/install) v2 installed.
* Install dependencies
    * Install Flutter dependencies: `flutter pub get`
    * Install Node dependencies: `npm install`
* Bundle [extension scripts](web/src/) using webpack: `npm run build`
* Build the flutter application: `flutter build web --web-renderer html --csp` 

## Run local build on Chrome
* On Chrome, go to Settings -> Extensions. Or click on the extensions icon in the top right corner and select 'Manage Exensions'
* Toggle 'Developer mode' from the top-right corner
* Select 'Load unpacked' from the menu that appears on the top
* Navigate to and select the directory with path `ribn/build/web/`
* The app should be loaded and you should be able to open it like you would any other extension 

## Using Test Credentials
* Change `Line 28` in `main.dart` to: `await Redux.initStore(initTestStore: true);`
* PW is Topl1234
* Seed phrase can be found in `test_data.dart`

## Feature requests and bugs
Please file feature requests and bugs at the [issue tracker](https://github.com/Topl/ribn/issues). If you want to contribute to this library, please submit a Pull Request.

