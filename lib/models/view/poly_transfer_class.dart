import 'package:freezed_annotation/freezed_annotation.dart';

part 'poly_transfer_class.freezed.dart';

@freezed
class PolyTransferClass with _$PolyTransferClass {
  const factory PolyTransferClass({
    required int amount,
    required String note,
    required String recipientAddress,
    required String validRecipientAddress,
  }) = _PolyTransferClass;
}
