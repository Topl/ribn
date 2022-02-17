import 'package:ribn/models/internal_message.dart';

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
  final InternalMessage msg;
  SendInternalMsgAction(this.msg);
}

class ReceiveInternalMsgAction {
  final String msg;
  ReceiveInternalMsgAction(this.msg);
}

class DownloadAsFile {
  final String fileName;
  final String text;
  const DownloadAsFile(this.fileName, this.text);
}

class DeleteWalletAction {
  const DeleteWalletAction();
}

class ResetAppStateAction {
  const ResetAppStateAction();
}
