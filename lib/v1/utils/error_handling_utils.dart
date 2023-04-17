// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:ribn/v1/constants/routes.dart';
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/providers/logger_provider.dart';
import 'package:ribn/v1/utils/navigation_utils.dart';

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
