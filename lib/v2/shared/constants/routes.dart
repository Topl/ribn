// Flutter imports:
import 'package:flutter/material.dart';

class Routes {
  const Routes._();

  /// A [RouteObserver] that can be attached to widgets to allow listening for route changes.
  static RouteObserver routeObserver = RouteObserver();

  /// Routes used throughout the application.
  static const welcome = '/welcome';
  static const home = '/home';
}
