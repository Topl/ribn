import 'package:ribn/constants/routes.dart';
import 'package:ribn/utils/navigation_utils.dart';

// QQQQ comment and discuss how this should replace [ApiErrorAction]
// Epic middleware line 62
Future<void> handleApiError({
  required String errorMessage,
}) async {
  await navigateToRoute(
    route: Routes.error,
    arguments: errorMessage,
  );
}
