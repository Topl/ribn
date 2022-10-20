class TransactionHistoryEntry {
  final List to;
  final List from;
  final List newBoxes;
  final List boxesToRemove;
  final String id;
  final String txType;
  final String timestamp;
  final Map signatures;
  final dynamic data;
  final bool minting;
  final String txId;
  final String fee;
  final String propositionType;
  final Map block;
  final int v;

  const TransactionHistoryEntry({
    required this.to,
    required this.from,
    required this.newBoxes,
    required this.boxesToRemove,
    required this.id,
    required this.txType,
    required this.timestamp,
    required this.signatures,
    required this.data,
    required this.minting,
    required this.txId,
    required this.fee,
    required this.propositionType,
    required this.block,
    required this.v,
  });

  factory TransactionHistoryEntry.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryEntry(
      to: json['to'],
      from: json['from'],
      newBoxes: json['newBoxes'],
      boxesToRemove: json['boxesToRemove'],
      id: json['_id'],
      txType: json['txType'],
      timestamp: json['timestamp'],
      signatures: json['signatures'],
      data: json['data'],
      minting: json['minting'],
      txId: json['txId'],
      fee: json['fee'],
      propositionType: json['propositionType'],
      block: json['block'],
      v: json['__v'],
    );
  }
}
