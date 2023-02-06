import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/constants/environment_config.dart';
import 'package:ribn/platform/platform.dart';

final appVersionProvider = Provider<String>((ref) {
  if (EnvironmentConfig.nightlyBuildVersion == "") {
    try {
      return PlatformUtils.instance.getCurrentAppVersion();
    } catch (e) {
      return 'Dev';
    }
  }

  // Returns Nightly Build version supplies via compile time variables
  return "Nightly Build ${EnvironmentConfig.nightlyBuildVersion}";
});
