// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:brambldart/brambldart.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/actions/internal_message_actions.dart';
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/ribn_network.dart';
import 'package:ribn/models/transfer_details.dart';
import 'package:ribn/repositories/keychain_repository.dart';
import 'package:ribn/repositories/transaction_repository.dart';

/// The transaction middleware that handles all async operations needed for the complete transaction flow.
List<Middleware<AppState>> createTransactionMiddleware(
  TransactionRepository transactionRepo,
  KeychainRepository keychainRepo,
) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, InitiateTxAction>(
        _initiateTx(transactionRepo, keychainRepo),),
    TypedMiddleware<AppState, CreateRawTxAction>(_createRawTx(transactionRepo)),
    TypedMiddleware<AppState, SignAndBroadcastTxAction>(
        _signAndBroadcastTx(transactionRepo, keychainRepo),),
    TypedMiddleware<AppState, SignExternalTxAction>(
        _signExternalTx(transactionRepo, keychainRepo),),
  ];
}

/// Dispatches [ToggleLoadingRawTxAction] to indicate that the tx has been initiated.
///
/// Updates the [TransferDetails] with some defaults like the sender, change, and consolidation addresses, as well as
/// the current network, before dispatching [CreateRawTxAction].
void Function(
        Store<AppState> store, InitiateTxAction action, NextDispatcher next,)
    _initiateTx(
  TransactionRepository transactionRepo,
  KeychainRepository keychainRepo,
) {
  return (store, action, next) async {
    try {
      /// The sender defaults to the first address in the list of locally stored addresses
      final RibnAddress sender =
          store.state.keychainState.currentNetwork.addresses.first;
      final RibnNetwork currNetwork = store.state.keychainState.currentNetwork;
      final TransferDetails transferDetails = action.transferDetails.copyWith(
        senders: [sender],
        change: sender,
        consolidation: sender,
        networkId: currNetwork.networkId,
      );
      next(CreateRawTxAction(transferDetails, action.completer));
    } catch (e) {
      action.completer.complete(null);
    }
  };
}

/// Creates the rawTx and navigates to the [Routes.txReview] page.
///
/// Also dispatches [ToggleLoadingRawTxAction] to stop the loading indicator.
void Function(
        Store<AppState> store, CreateRawTxAction action, NextDispatcher next,)
    _createRawTx(
  TransactionRepository transactionRepo,
) {
  return (store, action, next) async {
    try {
      final Map<String, dynamic> result = await transactionRepo.createRawTx(
        store.state.keychainState.currentNetwork.client!,
        action.transferDetails,
      );
      final TransactionReceipt transactionReceipt =
          result['rawTx'] as TransactionReceipt;
      final Uint8List messageToSign = result['messageToSign'] as Uint8List;
      final TransferDetails transferDetails = action.transferDetails.copyWith(
        transactionReceipt: transactionReceipt,
        messageToSign: messageToSign,
      );
      action.completer.complete(transferDetails);
    } catch (e) {
      action.completer.complete(null);
    }
  };
}

/// Gets the [Credentials] for the senders in the transfer.
///
/// Signs and broadcasts the transactions, updates the [TransferDetails] with the txId,
/// and navigates to the confirmation page.
void Function(Store<AppState> store, SignAndBroadcastTxAction action,
    NextDispatcher next,) _signAndBroadcastTx(
  TransactionRepository transactionRepo,
  KeychainRepository keychainRepo,
) {
  return (store, action, next) async {
    try {
      final List<Credentials> credentials = keychainRepo.getCredentials(
        store.state.keychainState.hdWallet!,
        action.transferDetails.senders,
      );
      final String transactionId = await transactionRepo.signAndBroadcastTx(
        store.state.keychainState.currentNetwork.client!,
        credentials,
        action.transferDetails.transactionReceipt!,
        action.transferDetails.messageToSign!,
      );
      final TransferDetails transferDetails =
          action.transferDetails.copyWith(transactionId: transactionId);

      /// Update the locally stored asset details if minting a new asset
      if (transferDetails.transferType == TransferType.mintingAsset) {
        next(
          UpdateAssetDetailsAction(
            assetCode: action.transferDetails.assetCode.toString(),
            unit: transferDetails.assetDetails?.unit,
            icon: transferDetails.assetDetails?.icon,
            longName: transferDetails.assetDetails?.longName,
          ),
        );
      }
      action.completer.complete(transferDetails);
    } catch (e) {
      action.completer.complete(null);
    }
  };
}

void Function(
        Store<AppState> store, SignExternalTxAction action, NextDispatcher next,)
    _signExternalTx(
  TransactionRepository transactionRepo,
  KeychainRepository keychainRepo,
) {
  return (store, action, next) async {
    try {
      final Map<String, dynamic> transferDetails = {};

      transferDetails['messageToSign'] = Base58Data.validated(
              action.pendingRequest.data!['messageToSign'] as String,)
          .value;

      final TransactionReceipt transactionReceipt =
          TransactionReceipt.fromJson(action.pendingRequest.data!['rawTx']);

      transferDetails['rawTx'] = transactionReceipt;

      final List<String> rawTxSenders = transactionReceipt.from!
          .map((e) => e.senderAddress.toBase58())
          .toList();

      final List<RibnAddress> sendersInWallet =
          List.from(store.state.keychainState.currentNetwork.addresses)
            ..retainWhere(
                (addr) => rawTxSenders.contains(addr.toplAddress.toBase58()),);

      if (sendersInWallet.isEmpty) {
        final InternalMessage response = InternalMessage(
          method: InternalMethods.returnResponse,
          data: {'message': 'No matching senders found in wallet'},
          target: action.pendingRequest.target,
          sender: InternalMessage.defaultSender,
          id: action.pendingRequest.id,
          origin: action.pendingRequest.origin,
        );
        next(SendInternalMsgAction(response));
      } else {
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
          method: InternalMethods.returnResponse,
          data: signedTx.toBroadcastJson(),
          target: action.pendingRequest.target,
          sender: InternalMessage.defaultSender,
          id: action.pendingRequest.id,
          origin: action.pendingRequest.origin,
        );

        next(SendInternalMsgAction(response));
      }
    } catch (e) {
      final InternalMessage response = InternalMessage(
        method: InternalMethods.returnResponse,
        data: {'message': 'Unable to sign tx'},
        target: action.pendingRequest.target,
        sender: InternalMessage.defaultSender,
        id: action.pendingRequest.id,
        origin: action.pendingRequest.origin,
      );
      next(SendInternalMsgAction(response));
    }
  };
}
