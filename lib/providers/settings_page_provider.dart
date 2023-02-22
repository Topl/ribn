import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/models/state/settings_state.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/providers/store_provider.dart';

final canDisconnectDAppsProvider =
    FutureProvider.autoDispose<bool>((ref) async {
  if (!kIsWeb) return false;

  final List<String> dApps = await PlatformUtils.instance
      .convertToFuture(PlatformUtils.instance.getDAppList());
  await PlatformUtils.instance.consoleLog(dApps.toString());

  return dApps.isNotEmpty;
});

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingState>(
    (ref) => SettingsNotifier(ref));

class SettingsNotifier extends StateNotifier<SettingState> {
  final Ref ref;

  SettingsNotifier(this.ref)
      : super(SettingState.fromStore(ref.read(storeProvider))) {}
}
