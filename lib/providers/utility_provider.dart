import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/constants/environment_config.dart';
import 'package:ribn/models/file.dart';
import 'package:ribn/platform/platform.dart';

// makes calling provider easier
export 'package:ribn/models/file.dart';

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


final downloadFileProvider = Provider.autoDispose.family<void, File>((ref, File) {
  return PlatformUtils.instance.downloadFile(File.fileName, File.text);
});

