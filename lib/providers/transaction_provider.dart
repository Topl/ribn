import 'dart:async';

import 'package:brambldart/brambldart.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/ribn_network.dart';
import 'package:ribn/models/transfer_details.dart';
import 'package:ribn/providers/internal_message_provider.dart';
import 'package:ribn/providers/store_provider.dart';
import 'package:ribn/repositories/keychain_repository.dart';
import 'package:ribn/repositories/transaction_repository.dart';

final transactionProvider = StateNotifierProvider<StateNotifier, void>((ref) {
  return TransactionNotifier(ref);
});

class TransactionNotifier extends StateNotifier<void> {
  final Ref ref;
  TransactionNotifier(this.ref) : super(null);

  Future<void> initiateTx({
    required TransferDetails transferDetails,
    required Completer<TransferDetails?> completer,
  }) async {
    try {
      final Store<AppState> store = ref.read(storeProvider);

      /// The sender defaults to the first address in the list of locally stored addresses
      final RibnAddress sender = store.state.keychainState.currentNetwork.addresses.first;
      final RibnNetwork currNetwork = store.state.keychainState.currentNetwork;

      transferDetails = transferDetails.copyWith(
        senders: [sender],
        change: sender,
        consolidation: sender,
        networkId: currNetwork.networkId,
      );

      await createRawTx(transferDetails: transferDetails, completer: completer);
    } catch (e) {
      completer.complete(null);
    }
  }

  Future<void> createRawTx({
    required TransferDetails transferDetails,
    required Completer<TransferDetails?> completer,
  }) async {
    try {
      final Store<AppState> store = ref.read(storeProvider);
      TransactionRepository transactionRepo = TransactionRepository();

      final Map<String, dynamic> result = await transactionRepo.createRawTx(
        store.state.keychainState.currentNetwork.client!,
        transferDetails,
      );
      final TransactionReceipt transactionReceipt = result['rawTx'] as TransactionReceipt;
      final Uint8List messageToSign = result['messageToSign'] as Uint8List;
      transferDetails = transferDetails.copyWith(
        transactionReceipt: transactionReceipt,
        messageToSign: messageToSign,
      );
      completer.complete(transferDetails);
    } catch (e) {
      completer.complete(null);
    }
  }

  Future<void> signAndBroadcastTx({
    required TransferDetails transferDetails,
    required Completer<TransferDetails?> completer,
  }) async {
    try {
      final Store<AppState> store = ref.read(storeProvider);
      final TransactionRepository transactionRepo = TransactionRepository();
      final KeychainRepository keychainRepo = KeychainRepository();

      final List<Credentials> credentials = keychainRepo.getCredentials(
        store.state.keychainState.hdWallet!,
        transferDetails.senders,
      );
      final String transactionId = await transactionRepo.signAndBroadcastTx(
        store.state.keychainState.currentNetwork.client!,
        credentials,
        transferDetails.transactionReceipt!,
        transferDetails.messageToSign!,
      );
      transferDetails = transferDetails.copyWith(transactionId: transactionId);

      /// Update the locally stored asset details if minting a new asset
      if (transferDetails.transferType == TransferType.mintingAsset) {
        await store.dispatch(
          UpdateAssetDetailsAction(
            assetCode: transferDetails.assetCode.toString(),
            unit: transferDetails.assetDetails?.unit,
            icon: transferDetails.assetDetails?.icon,
            longName: transferDetails.assetDetails?.longName,
          ),
        );
      }
      completer.complete(transferDetails);
    } catch (e) {
      completer.complete(null);
    }
  }

  Future<void> signExternalTx({
    required InternalMessage pendingRequest,
  }) async {
    try {
      final Store<AppState> store = ref.read(storeProvider);
      final TransactionRepository transactionRepo = TransactionRepository();
      final KeychainRepository keychainRepo = KeychainRepository();
      final Map<String, dynamic> transferDetails = {};

      transferDetails['messageToSign'] = Base58Data.validated(
        pendingRequest.data!['messageToSign'] as String,
      ).value;

      final TransactionReceipt transactionReceipt =
          TransactionReceipt.fromJson(pendingRequest.data!['rawTx']);

      transferDetails['rawTx'] = transactionReceipt;

      final List<String> rawTxSenders =
          transactionReceipt.from!.map((e) => e.senderAddress.toBase58()).toList();

      final List<RibnAddress> sendersInWallet =
          List.from(store.state.keychainState.currentNetwork.addresses)
            ..retainWhere(
              (addr) => rawTxSenders.contains(addr.toplAddress.toBase58()),
            );

      if (sendersInWallet.isEmpty) {
        final InternalMessage response = InternalMessage(
          method: InternalMethods.returnResponse,
          data: {'message': 'No matching senders found in wallet'},
          target: pendingRequest.target,
          sender: InternalMessage.defaultSender,
          id: pendingRequest.id,
          origin: pendingRequest.origin,
        );
        ref.read(internalMessageProvider.notifier).sendInternalMessage(message: response);
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
          target: pendingRequest.target,
          sender: InternalMessage.defaultSender,
          id: pendingRequest.id,
          origin: pendingRequest.origin,
        );

        ref.read(internalMessageProvider.notifier).sendInternalMessage(message: response);
      }
    } catch (e) {
      final InternalMessage response = InternalMessage(
        method: InternalMethods.returnResponse,
        data: {'message': 'Unable to sign tx'},
        target: pendingRequest.target,
        sender: InternalMessage.defaultSender,
        id: pendingRequest.id,
        origin: pendingRequest.origin,
      );
      ref.read(internalMessageProvider.notifier).sendInternalMessage(message: response);
    }
  }
}
