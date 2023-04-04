// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'file.freezed.dart';

@freezed
class File with _$File {
  const factory File({
    @Default("") String fileName,
    @Default("") String text,
  }) = _FileState;
}
