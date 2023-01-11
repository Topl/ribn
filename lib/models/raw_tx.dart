// To parse this JSON data, do
//
//     final rawTx = rawTxFromJson(jsonString);

// Dart imports:
import 'dart:convert';
import 'dart:typed_data';
RawTx rawTxFromJson(String str) => RawTx.fromJson(json.decode(str));

String rawTxToJson(RawTx data) => json.encode(data.toJson());

class RawTx {
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

  final String txType;
  final int timestamp;
  final List<NewBox> newBoxes;
  final dynamic data;
  final List<List<String>> from;
  final bool minting;
  final String txId;
  final List<String> boxesToRemove;
  final String fee;
  final List<List<dynamic>> to;
  final String propositionType;
  final String messageToSign;

  factory RawTx.fromJson(Map<String, dynamic> json) => RawTx(
        txType: json['txType'],
        timestamp: json['timestamp'],
        newBoxes:
            List<NewBox>.from(json['newBoxes'].map(NewBox.fromJson)),
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

class NewBox {
  NewBox({
    required this.nonce,
    required this.id,
    required this.evidence,
    required this.type,
    required this.value,
  });

  final String nonce;
  final String id;
  final String evidence;
  final String type;
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

  final String type;
  final String quantity;
  final String assetCode;
  final dynamic metadata;
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
