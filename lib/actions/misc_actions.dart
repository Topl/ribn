import 'dart:async';

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

class DownloadAsFileAction {
  final String fileName;
  final String text;
  const DownloadAsFileAction(this.fileName, this.text);
}

class DeleteWalletAction {
  final String password;
  final Completer<bool> completer;
  const DeleteWalletAction({required this.password, required this.completer});
}

class ResetAppStateAction {
  const ResetAppStateAction();
}

class SetAppVersion {
  final String appVersion;
  const SetAppVersion(this.appVersion);
}
