// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:brambldart/brambldart.dart';

// Project imports:
import 'package:ribn/constants/network_utils.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/transfer_details.dart';

// import 'package:brambldart/src/model/box/token_value_holder.dart';

class TransactionRepository {
  const TransactionRepository();

  /// Formats the tx based on the [transferType] in [transferDetails].
  /// Sends the request for creating a rawTx.
  Future<Map<String, dynamic>> createRawTx(
    BramblClient client,
    TransferDetails transferDetails,
  ) async {
    switch (transferDetails.transferType) {
      case TransferType.polyTransfer:
        {
          final List<ToplAddress> senders =
              transferDetails.senders.map((e) => e.toplAddress).toList();
          final ToplAddress recipient =
              ToplAddress.fromBase58(transferDetails.recipient);
          final PolyTransaction polyTransaction = PolyTransaction(
            recipients: [
              SimpleRecipient(
                recipient,
                SimpleValue(quantity: transferDetails.amount.toString()),
              )
            ],
            sender: senders,
            propositionType: senders.first.proposition.propositionName,
            changeAddress: transferDetails.change!.toplAddress,
            fee: NetworkUtils.networkFees[transferDetails.networkId],
            data: Latin1Data.validated(transferDetails.data),
          );
          final Map<String, dynamic> rawTx = await client.sendRawPolyTransfer(
              polyTransaction: polyTransaction,);
          return rawTx;
        }
      case TransferType.assetTransfer:
        {
          final List<ToplAddress> senders =
              transferDetails.senders.map((e) => e.toplAddress).toList();
          final ToplAddress recipient =
              ToplAddress.fromBase58(transferDetails.recipient);
          final AssetValue assetValue = AssetValue(
            transferDetails.amount,
            transferDetails.assetCode!,
            SecurityRoot.empty(),
            '',
            'Asset',
          );
          final AssetTransaction assetTransaction = AssetTransaction(
            recipients: [AssetRecipient(recipient, assetValue)],
            sender: senders,
            changeAddress: transferDetails.change!.toplAddress,
            consolidationAddress: transferDetails.consolidation!.toplAddress,
            propositionType: senders.first.proposition.propositionName,
            minting: false,
            assetCode: transferDetails.assetCode!,
            fee: NetworkUtils.networkFees[transferDetails.networkId],
            data: Latin1Data.validated(transferDetails.data),
          );
          final Map<String, dynamic> rawTx = await client.sendRawAssetTransfer(
              assetTransaction: assetTransaction,);
          return rawTx;
        }
      case (TransferType.mintingAsset):
      case (TransferType.remintingAsset):
        {
          final ToplAddress issuer = transferDetails.assetCode!.issuer;
          final ToplAddress recipient =
              ToplAddress.fromBase58(transferDetails.recipient);
          final AssetValue assetValue = AssetValue(
            transferDetails.amount,
            transferDetails.assetCode!,
            SecurityRoot.empty(),
            '',
            'Asset',
          );
          final AssetTransaction assetTransaction = AssetTransaction(
            recipients: [AssetRecipient(recipient, assetValue)],
            sender: [issuer],
            changeAddress: issuer,
            consolidationAddress: issuer,
            propositionType: issuer.proposition.propositionName,
            minting: true,
            assetCode: transferDetails.assetCode!,
            fee: NetworkUtils.networkFees[transferDetails.networkId],
            data: Latin1Data.validated(transferDetails.data),
          );
          final Map<String, dynamic> rawTx = await client.sendRawAssetTransfer(
              assetTransaction: assetTransaction,);
          return rawTx;
        }
      default:
        {
          throw Exception('Invalid transfer type');
        }
    }
  }

  Future<TransactionReceipt> signTx(
    BramblClient client,
    List<Credentials> creds,
    Map<String, dynamic> transferDetails,
  ) async {
    return await client.signTransaction(
      creds,
      transferDetails[Strings.rawTx] as TransactionReceipt,
      transferDetails[Strings.messageToSign] as Uint8List,
    );
  }

  Future<String> broadcastTx(
      BramblClient client, TransactionReceipt signedTx,) async {
    return await client.sendSignedTransaction(signedTx);
  }

  /// Signs and broadcasts the tx.
  Future<String> signAndBroadcastTx(
    BramblClient client,
    List<Credentials> creds,
    TransactionReceipt rawTx,
    Uint8List messageToSign,
  ) async {
    return await client.sendTransaction(creds, rawTx, messageToSign);
  }
}
