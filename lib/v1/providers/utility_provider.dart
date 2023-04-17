// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/v1/constants/environment_config.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/models/file.dart';
import 'package:ribn/v1/platform/platform.dart';
import 'package:ribn/v1/providers/store_provider.dart';

// makes calling provider easier
export 'package:ribn/v1/models/file.dart';

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

// TODO requires rewrite after keychain refactor
final currentNetworkProvider = Provider<String>((ref) {
  final Store<AppState> store = ref.read(storeProvider);
  return store.state.keychainState.currentNetwork.networkName;
});

final currentWalletAddressProvider = Provider<String>((ref) {
  final Store<AppState> store = ref.read(storeProvider);
  return store.state.keychainState.currentNetwork.addresses.first.toplAddress.toBase58();
});
