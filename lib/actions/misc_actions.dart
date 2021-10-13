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

class SendInternalMsgAction {
  final String msg;
  SendInternalMsgAction(this.msg);
}

class ReceiveInternalMsgAction {
  final String msg;
  ReceiveInternalMsgAction(this.msg);
}
