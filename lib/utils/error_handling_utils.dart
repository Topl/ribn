// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/constants/routes.dart';
import 'package:ribn/providers/logger_provider.dart';
import 'package:ribn/utils/navigation_utils.dart';

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
