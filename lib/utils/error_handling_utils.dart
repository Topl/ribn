import 'package:ribn/constants/routes.dart';
import 'package:ribn/utils/navigation_utils.dart';

/// This will handle an error and navigate to an error page
Future<void> handleApiError({
  required String errorMessage,
}) async {
  await navigateToRoute(
    route: Routes.error,
    arguments: errorMessage,
  );
}
