class PersistAppState {}

class FailedToPersistAppStateAction {}

class ApiErrorAction {
  String errorMessage;
  ApiErrorAction(this.errorMessage);
}

class NavigateToRoute {
  final String route;
  final Object? arguments;
  NavigateToRoute(this.route, {this.arguments});
}

class ResetAppStateAction {
  const ResetAppStateAction();
}

class SetAppVersion {
  final String appVersion;
  const SetAppVersion(this.appVersion);
}
