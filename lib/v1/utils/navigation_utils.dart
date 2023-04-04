// Project imports:
import 'package:ribn/v1/constants/keys.dart';

Future<void> navigateToRoute({
  required String route,
  Object? arguments,
}) async {
  await Keys.navigatorKey.currentState?.pushNamed(
    route,
    arguments: arguments,
  );
}
