// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/platform/platform.dart';
import 'package:ribn/providers/packages/flutter_secure_storage_provider.dart';

final analyticsUserTypeProvider = Provider<UserType>((ref) {
  return UserType._(ref);
});

class UserType {
  static const _analyticsUserSeenFirstKey = "_analyticsUserSeenFirstKey";

  late int _firstSeen;

  UserType._(ref) {
    PlatformLocalStorage.instance
        .getKVInSecureStorage(_analyticsUserSeenFirstKey, override: ref.read(flutterSecureStorageProvider)())
        .then((value) {
      if (value == null) {
        // register current time
        int currentValue = DateTime.now().millisecondsSinceEpoch;
        PlatformLocalStorage.instance
            .saveKVInSecureStorage(_analyticsUserSeenFirstKey, currentValue as String,
                override: ref.read(flutterSecureStorageProvider)())
            .then((value) => _firstSeen = currentValue);
      } else {
        _firstSeen = int.parse(value);
      }
    });
  }

  // Have 24 hours passed since User has been seen
  bool isUserNew() {
    // User is not new
    final lastSeen = DateTime.fromMillisecondsSinceEpoch(_firstSeen);
    final now = DateTime.now();
    final difference = now.difference(lastSeen);
    // 24 hours have passed
    return difference.inHours < 24 ? true : false;
  }
}
