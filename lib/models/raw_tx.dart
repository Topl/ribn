// To parse this JSON data, do
//
//     final rawTx = rawTxFromJson(jsonString);

import 'dart:convert';

RawTx rawTxFromJson(String str) => RawTx.fromJson(json.decode(str));

String rawTxToJson(RawTx data) => json.encode(data.toJson());

class RawTx {
  /// Transfer Type from Bifrost. Can be three different types:
  /// [PolyTransfer](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/modifier/transaction/PolyTransfer.scala),
  /// [AssetTransfer](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/modifier/transaction/AssetTransfer.scala),
  /// [ArbitTransfer](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/modifier/transaction/ArbitTransfer.scala)
  final String txType;

  /// The time stamp of the transaction
  final int timestamp;

  /// The number of boxes that were generated with this transaction.
  final List<NewBox> newBoxes;

  /// Byte data represented by Latin-1 encoded text. [Latin1Data](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/utils/StringDataTypes.scala)
  final dynamic data;

  /// The sender/s address/s of this transaction.
  final List<List<String>> from;

  /// Whether this transfer will be a minting transfer
  final bool minting;

  /// The Id of the transaction
  final String txId;

  /// The boxes that will be deleted as a result of this transaction
  final List<String> boxesToRemove;

  /// Fee to be paid to the network for the transaction (unit is nanoPoly)
  final String fee;

  /// The recipient/s address/s of this transaction.
  final List<List<dynamic>> to;

  /// The propositionType that has or will be used by the sender to generate the proposition eg., PublicKeyCurve25519, ThresholdCurve25519. [Proposition](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/attestation/Proposition.scala)
  final String propositionType;

  /// The message that will have to be signed by the sender of this transaction
  final String messageToSign;

  RawTx({
    required this.txType,
    required this.timestamp,
    required this.newBoxes,
    required this.data,
    required this.from,
    required this.minting,
    required this.txId,
    required this.boxesToRemove,
    required this.fee,
    required this.to,
    required this.propositionType,
    required this.messageToSign,
  });

  factory RawTx.fromJson(Map<String, dynamic> json) => RawTx(
        txType: json['txType'],
        timestamp: json['timestamp'],
        newBoxes: List<NewBox>.from(json['newBoxes'].map((x) => NewBox.fromJson(x))),
        data: json['data'],
        from: List<List<String>>.from(
          json['from'].map((x) => List<String>.from(x.map((x) => x))),
        ),
        minting: json['minting'],
        txId: json['txId'],
        boxesToRemove: List<String>.from(json['boxesToRemove'].map((x) => x)),
        fee: json['fee'],
        to: List<List<dynamic>>.from(
          json['to'].map((x) => List<dynamic>.from(x.map((x) => x))),
        ),
        propositionType: json['propositionType'],
        messageToSign: json['messageToSign'],
      );

  Map<String, dynamic> toJson() => {
        'txType': txType,
        'timestamp': timestamp,
        'newBoxes': List<dynamic>.from(newBoxes.map((x) => x.toJson())),
        'data': data,
        'from': List<dynamic>.from(
          from.map((x) => List<dynamic>.from(x.map((x) => x))),
        ),
        'minting': minting,
        'txId': txId,
        'boxesToRemove': List<dynamic>.from(boxesToRemove.map((x) => x)),
        'fee': fee,
        'to': List<dynamic>.from(
          to.map((x) => List<dynamic>.from(x.map((x) => x))),
        ),
        'propositionType': propositionType,
        'messageToSign': messageToSign,
      };
}

/// [TokenBox](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/modifier/box/Box.scala)
class NewBox {
  NewBox({
    required this.nonce,
    required this.id,
    required this.evidence,
    required this.type,
    required this.value,
  });

  /// Number used once
  final String nonce;

  /// Id of boxs
  final String id;

  /// Evidence content serves as a fingerprint (or commitment) of a particular proposition that is used to lock a box. [Evidence](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/attestation/Evidence.scala)
  final String evidence;

  /// Type of box. Can be 3 types:
  /// [ArbitBox](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/modifier/box/ArbitBox.scala),
  /// [PolyBox](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/modifier/box/PolyBox.scala),
  /// [AssetBox](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/modifier/box/AssetBox.scala)
  final String type;

  /// Value of box
  final Value value;

  factory NewBox.fromJson(Map<String, dynamic> json) => NewBox(
        nonce: json['nonce'],
        id: json['id'],
        evidence: json['evidence'],
        type: json['type'],
        value: Value.fromJson(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'nonce': nonce,
        'id': id,
        'evidence': evidence,
        'type': type,
        'value': value.toJson(),
      };
}

class Value {
  Value({
    required this.type,
    required this.quantity,
    required this.assetCode,
    required this.metadata,
    required this.securityRoot,
  });

  /// Can either be [Simple](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/modifier/box/TokenValueHolder.scala) of
  /// [Asset](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/modifier/box/TokenValueHolder.scala)
  final String type;

  /// Quantity of box, unit is in nanoPolys
  final String quantity;

  /// AssetCode serves as a unique identifier for user issued assets [AssetCode](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/modifier/box/AssetCode.scala)
  final String assetCode;

  /// Additional [Latin1Data](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/utils/StringDataTypes.scala) MetaData
  final dynamic metadata;

  /// [SecurityRoot](https://github.com/Topl/Bifrost/blob/main/common/src/main/scala/co/topl/modifier/box/SecurityRoot.scala)
  final String securityRoot;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        type: json['type'],
        quantity: json['quantity'],
        assetCode: json['assetCode'],
        metadata: json['metadata'],
        securityRoot: json['securityRoot'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'quantity': quantity,
        'assetCode': assetCode,
        'metadata': metadata,
        'securityRoot': securityRoot,
      };
}
