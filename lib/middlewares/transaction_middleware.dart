import 'package:brambldart/brambldart.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/ribn_network.dart';
import 'package:ribn/repositories/keychain_repository.dart';
import 'package:ribn/repositories/transaction_repository.dart';

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
    TypedMiddleware<AppState, SignExternalTxAction>(_signExternalTx(transactionRepo, keychainRepo)),
  ];
}

void Function(Store<AppState> store, InitiateTxAction action, NextDispatcher next) _initiateTx(
    TransactionRepository transactionRepo, KeychainRepository keychainRepo) {
  return (store, action, next) async {
    try {
      RibnNetwork currNetwork = store.state.keychainState.currentNetwork;
      List<RibnAddress> senders = transactionRepo.getSenderAddresses(
        action.transferDetails[Strings.transferType] as String,
        currNetwork,
        polyAmount: int.parse(action.transferDetails[Strings.amount] as String),
        assetAmount: action.transferDetails[Strings.asset] as AssetAmount?,
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
        Strings.sender: senders,
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
      final List<RibnAddress> senders = action.transferDetails[Strings.sender] as List<RibnAddress>;
      final List<Credentials> credentials = keychainRepo.getCredentials(
        store.state.keychainState.hdWallet!,
        senders,
      );
      final TransactionReceipt signedTx = await transactionRepo.signTx(
        store.state.keychainState.currentNetwork.client!,
        credentials,
        action.transferDetails,
      );
      next(
        BroadcastTxAction(
          signedTx,
          changeAddress: action.transferDetails[Strings.change] as RibnAddress?,
        ),
      );
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

void Function(Store<AppState> store, BroadcastTxAction action, NextDispatcher next) _broadcastTx(
    TransactionRepository transactionRepo) {
  return (store, action, next) async {
    try {
      await transactionRepo.broadcastTx(
        store.state.keychainState.currentNetwork.client!,
        action.signedTx,
      );
      if (action.changeAddress != null) {
        store.dispatch(AddAddressesAction(addresses: [action.changeAddress!]));
      }
    } catch (e) {
      next(ApiErrorAction(e.toString()));
    }
  };
}

void Function(Store<AppState> store, SignExternalTxAction action, NextDispatcher next) _signExternalTx(
    TransactionRepository transactionRepo, KeychainRepository keychainRepo) {
  return (store, action, next) async {
    try {
      final Map<String, dynamic> transferDetails = action.pendingRequest.data!;
      transferDetails['messageToSign'] =
          Base58Data.validated(transferDetails['messageToSign'] as String).value;
      final TransactionReceipt transactionReceipt = TransactionReceipt.fromJson(transferDetails);
      transferDetails['rawTx'] = transactionReceipt;
      final List<String> rawTxSenders =
          transactionReceipt.from!.map((e) => e.senderAddress.toBase58()).toList();
      final List<RibnAddress> sendersInWallet = List.from(store.state.keychainState.currentNetwork.addresses)
        ..retainWhere((addr) => rawTxSenders.contains(addr.address.toBase58()));
      final List<Credentials> credentials = keychainRepo.getCredentials(
        store.state.keychainState.hdWallet!,
        sendersInWallet,
      );
      final TransactionReceipt signedTx = await transactionRepo.signTx(
        store.state.keychainState.currentNetwork.client!,
        credentials,
        transferDetails,
      );
      final InternalMessage response = InternalMessage(
        method: Strings.returnResponse,
        data: signedTx.toBroadcastJson(),
        target: action.pendingRequest.target,
        sender: 'ribn',
        id: action.pendingRequest.id,
        origin: action.pendingRequest.origin,
      );
      next(SendInternalMsgAction(response));
    } catch (e) {
      final InternalMessage response = InternalMessage(
        method: Strings.returnResponse,
        data: {'error': e.toString()},
        target: action.pendingRequest.target,
        sender: 'ribn',
        id: action.pendingRequest.id,
        origin: action.pendingRequest.origin,
      );
      next(SendInternalMsgAction(response));
    }
  };
}
