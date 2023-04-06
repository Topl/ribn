// Project imports:
import 'package:ribn/constants/keys.dart';

Future<void> navigateToRoute({
  required String route,
  Object? arguments,
}) async {
  await Keys.navigatorKey.currentState?.pushNamed(
    route,
    arguments: arguments,
  );
}
