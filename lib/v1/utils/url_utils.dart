// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/providers/packages/url_launcher_provider.dart';

Future<void> launchPrivacyPolicyUrl(WidgetRef ref) async {
  await ref.read(urlLauncherProvider)(Uri.parse(Strings.privacyPolicyUrl));
}

Future<void> launchTermsOfUse(WidgetRef ref) async {
  await ref.read(urlLauncherProvider)(Uri.parse(Strings.termsOfUseUrl));
}
