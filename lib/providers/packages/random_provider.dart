import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final randomProvider = Provider<Random Function()>((ref) {
  return () => Random.secure();
});
