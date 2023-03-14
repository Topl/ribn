// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final Provider<Future<bool> Function(Uri)> urlLauncherProvider = Provider<Future<bool> Function(Uri)>((ref) {
  return (Uri uri) => launchUrl(uri);
});
