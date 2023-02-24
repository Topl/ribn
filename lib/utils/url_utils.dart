import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/providers/packages/url_launcher_provider.dart';

Future<void> launchPrivacyPolicyUrl(WidgetRef ref) async {
  await ref.read(urlLauncherProvider)(Uri.parse('https://legal.topl.co/Privacy_Policy'));
}
