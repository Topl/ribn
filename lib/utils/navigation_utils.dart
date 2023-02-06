import 'package:ribn/constants/keys.dart';

// QQQQ Comment and talk
Future<void> navigateToRoute({
  required String route,
  Object? arguments,
}) async {
  await Keys.navigatorKey.currentState?.pushNamed(
    route,
    arguments: arguments,
  );
}
