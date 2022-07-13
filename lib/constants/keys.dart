import 'package:flutter/material.dart';

class Keys {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const isTestingEnvironment = bool.fromEnvironment('FLUTTER_TEST');
}
