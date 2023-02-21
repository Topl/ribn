import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final localAuthenticationProvider = Provider<LocalAuthentication Function()>((ref) {
  return () => LocalAuthentication();
});
