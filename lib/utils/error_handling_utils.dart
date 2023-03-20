// Package imports:
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/constants/routes.dart';
import 'package:ribn/providers/logger_provider.dart';
import 'package:ribn/utils/navigation_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:ribn/constants/strings.dart';

/// This will handle an error and navigate to an error page
Future<void> handleApiError({
  required String errorMessage,
}) async {
  final ProviderContainer container = ProviderContainer();

  container.read(loggerProvider).log(
        logLevel: LogLevel.Severe,
        loggerClass: LoggerClass.ApiError,
        message: errorMessage,
      );

  await navigateToRoute(
    route: Routes.error,
    arguments: errorMessage,
  );
}

Future<void> handleContactSupport() async {
  kIsWeb
  //Go to google docs link
  ? await launchUrlString(Strings.supportDocsURL)
  : await launchUrlString(Strings.supportEmailLink);
}