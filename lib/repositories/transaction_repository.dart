// ignore_for_file: implementation_imports

import 'dart:typed_data';

import 'package:brambldart/brambldart.dart';
import 'package:brambldart/client.dart';
import 'package:brambldart/credentials.dart';
import 'package:brambldart/model.dart';
import 'package:brambldart/src/model/box/token_value_holder.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/ribn_address.dart';
import 'package:ribn/models/ribn_network.dart';

class TransactionRepository {
  const TransactionRepository();

  Future<Map<String, dynamic>> createRawTx(
    BramblClient client,
    Map<String, dynamic> transferDetails,
  ) async {
    switch (transferDetails[Strings.transferType]) {
      case Strings.polyTransfer:
        {
          List<ToplAddress> senders =
              (transferDetails[Strings.sender] as List<RibnAddress>).map((addr) => addr.address).toList();
          ToplAddress change = (transferDetails[Strings.change] as RibnAddress).address;
          ToplAddress recipient = ToplAddress.fromBase58(transferDetails[Strings.recipient] as String);
          PolyTransaction polyTransaction = PolyTransaction(
            recipients: [
              SimpleRecipient(
                recipient,
                SimpleValue(quantity: transferDetails[Strings.amount].toString()),
              )
            ],
            sender: senders,
            propositionType: senders[0].proposition.propositionName,
            changeAddress: change,
            fee: Rules.networkFees[transferDetails[Strings.networkId]],
            // data: null,
          );
          Map<String, dynamic> rawTx = await client.sendRawPolyTransfer(polyTransaction: polyTransaction);
          return rawTx;
        }
      case Strings.assetTransfer:
        {
          List<ToplAddress> senders =
              (transferDetails[Strings.sender] as List<RibnAddress>).map((addr) => addr.address).toList();
          ToplAddress change = (transferDetails[Strings.change] as RibnAddress).address;
          AssetAmount assetAmount = transferDetails[Strings.asset] as AssetAmount;
          ToplAddress recipient = ToplAddress.fromBase58(transferDetails[Strings.recipient] as String);
          AssetValue assetValue = AssetValue(
            transferDetails[Strings.amount].toString(),
            assetAmount.assetCode,
            SecurityRoot.empty(),
            "",
            "Asset",
          );
          AssetTransaction assetTransaction = AssetTransaction(
            recipients: [AssetRecipient(recipient, assetValue)],
            sender: senders,
            changeAddress: change,
            consolidationAddress: change,
            propositionType: senders[0].proposition.propositionName,
            minting: false,
            assetCode: assetAmount.assetCode,
            fee: Rules.networkFees[transferDetails[Strings.networkId]],
          );
          Map<String, dynamic> rawTx = await client.sendRawAssetTransfer(assetTransaction: assetTransaction);
          return rawTx;
        }
      case Strings.minting:
        {
          List<ToplAddress> senders =
              (transferDetails[Strings.sender] as List<RibnAddress>).map((addr) => addr.address).toList();
          ToplAddress change = (transferDetails[Strings.change] as RibnAddress).address;
          AssetCode assetCode = AssetCode.initialize(
            Rules.assetCodeVersion,
            senders[0],
            transferDetails[Strings.assetName] as String,
            Rules.networkStrings[transferDetails[Strings.networkId]]!,
          );
          AssetValue assetValue = AssetValue(
            transferDetails[Strings.amount].toString(),
            assetCode,
            SecurityRoot.empty(),
            "",
            "Asset",
          );
          AssetTransaction assetTransaction = AssetTransaction(
            recipients: [AssetRecipient(senders[0], assetValue)],
            sender: senders,
            changeAddress: change,
            consolidationAddress: change,
            propositionType: senders[0].proposition.propositionName,
            minting: true,
            assetCode: assetCode,
            fee: Rules.networkFees[transferDetails[Strings.networkId]],
          );
          Map<String, dynamic> rawTx = await client.sendRawAssetTransfer(assetTransaction: assetTransaction);
          return rawTx;
        }
      default:
        {
          throw Exception("Invalid transfer type");
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

  Future<String> broadcastTx(BramblClient client, TransactionReceipt signedTx) async {
    return await client.sendSignedTransaction(signedTx);
  }

  List<RibnAddress> getSenderAddresses(
    String transferType,
    RibnNetwork currNetwork, {
    int? polyAmount,
    AssetAmount? assetAmount,
  }) {
    int networkFee = Rules.networkFees[currNetwork.networkId]!.quantity.toInt();
    switch (transferType) {
      case Strings.polyTransfer:
        {
          int targetAmount = polyAmount! + networkFee;
          return currNetwork.getAddrsWithSufficientPolys(targetAmount);
        }
      case Strings.minting:
        {
          return currNetwork.getAddrsWithSufficientPolys(networkFee);
        }
      case Strings.assetTransfer:
        {
          return [currNetwork.getAddrWithSufficientAssets(assetAmount!, networkFee)];
        }
      default:
        {
          throw Exception("Invalid transfer type");
        }
    }
  }
}
