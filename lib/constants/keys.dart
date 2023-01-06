// Flutter imports:
import 'package:flutter/material.dart';

class Keys {
  Keys._();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const isTestingEnvironment = bool.fromEnvironment('FLUTTER_TEST');
}
