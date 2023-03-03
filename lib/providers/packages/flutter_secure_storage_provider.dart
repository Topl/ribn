import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final flutterSecureStorageProvider = Provider<FlutterSecureStorage Function()>((ref) {
  print('QQQQ in prov 1');
  return () => FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
});
