// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';
import 'package:ribn/providers/packages/url_launcher_provider.dart';

Future<void> launchPrivacyPolicyUrl(WidgetRef ref) async {
  await ref.read(urlLauncherProvider)(Uri.parse(Strings.privacyPolicyUrl));
}

Future<void> launchTermsOfUse(WidgetRef ref) async {
  await ref.read(urlLauncherProvider)(Uri.parse(Strings.termsOfUseUrl));
}
