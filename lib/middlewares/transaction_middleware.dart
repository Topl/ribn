// ignore_for_file: implementation_imports

import 'package:mubrambl/brambldart.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/ribn_network.dart';
import 'package:ribn/repositories/keychain_repository.dart';
import 'package:ribn/repositories/transaction_repository.dart';
import 'package:mubrambl/src/credentials/credentials.dart';

/// The transaction middleware that handles all async operations needed for the complete transaction flow.
List<Middleware<AppState>> createTransactionMiddleware(
  TransactionRepository transactionRepo,
  KeychainRepository keychainRepo,
) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, InitiateTxAction>(_initiateTx(transactionRepo, keychainRepo)),
    TypedMiddleware<AppState, CreateRawTxAction>(_createRawTx(transactionRepo)),
    TypedMiddleware<AppState, SignTxAction>(_signTx(transactionRepo, keychainRepo)),
    TypedMiddleware<AppState, BroadcastTxAction>(_broadcastTx(transactionRepo)),
  ];
}

void Function(Store<AppState> store, InitiateTxAction action, NextDispatcher next) _initiateTx(
    TransactionRepository transactionRepo, KeychainRepository keychainRepo) {
  return (store, action, next) async {
    try {
      RibnNetwork currNetwork = store.state.keychainState.currentNetwork;
      RibnAddress senderAddr = transactionRepo.getSenderAddress(
        action.transferDetails[Strings.transferType],
        currNetwork,
        polyAmount: int.parse(action.transferDetails[Strings.amount]),
        assetAmount: action.transferDetails[Strings.asset],
      );
      RibnAddress changeAddr = keychainRepo.generateAddress(
        store.state.keychainState.hdWallet!,
        change: Rules.internalIdx,
        addr: currNetwork.getNextInternalAddressIndex(),
        networkId: currNetwork.networkId,
      );
      Map<String, dynamic> transferDetails = {
        ...action.transferDetails,
        Strings.change: changeAddr,
        Strings.sender: senderAddr,
        Strings.networkId: currNetwork.networkId,
      };
      next(CreateRawTxAction(transferDetails));
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

void Function(Store<AppState> store, CreateRawTxAction action, NextDispatcher next) _createRawTx(
    TransactionRepository transactionRepo) {
  return (store, action, next) async {
    try {
      Map<String, dynamic> rawTx = await transactionRepo.createRawTx(
        store.state.keychainState.currentNetwork.client!,
        action.transferDetails,
      );
      Map<String, dynamic> transferDetails = {
        ...action.transferDetails,
        ...rawTx,
      };
      next(SignTxAction(transferDetails));
    } catch (e) {
      next(ApiErrorAction((e).toString()));
    }
  };
}

void Function(Store<AppState> store, SignTxAction action, NextDispatcher next) _signTx(
    TransactionRepository transactionRepo, KeychainRepository keychainRepo) {
  return (store, action, next) async {
    try {
      RibnAddress senderAddr = action.transferDetails[Strings.sender];
      Credentials credentials = keychainRepo.getCredentials(
        store.state.keychainState.hdWallet!,
        account: senderAddr.accountIndex,
        change: senderAddr.changeIndex,
        addr: senderAddr.addressIndex,
        propositionType: senderAddr.address.proposition,
        networkId: senderAddr.address.networkId,
      );
      BramblClient client = store.state.keychainState.currentNetwork.client!;
      TransactionReceipt signedTx = await transactionRepo.signTx(client, credentials, action.transferDetails);
      next(BroadcastTxAction(signedTx, changeAddress: action.transferDetails[Strings.change]));
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

void Function(Store<AppState> store, BroadcastTxAction action, NextDispatcher next) _broadcastTx(
    TransactionRepository transactionRepo) {
  return (store, action, next) async {
    try {
      String txId = await transactionRepo.broadcastTx(
        store.state.keychainState.currentNetwork.client!,
        action.signedTx,
      );
      // add the newly generated change address to the wallet
      if (action.changeAddress != null) {
        store.dispatch(AddAddressesAction(addresses: [action.changeAddress!]));
      }
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}
