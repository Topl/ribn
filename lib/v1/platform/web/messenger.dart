@JS('ribn_messenger')
library messenger;

// Package imports:
import 'package:js/js.dart';

// Project imports:
import 'package:ribn/v1/platform/interfaces.dart';

@JS()
external void openConnection();
external void addPortMessageListener(Function fn);
external void sendPortMessage(String msg);

class Messenger implements IMessenger {
  Messenger._internal();
  static Messenger? _instance;
  factory Messenger() {
    _instance ??= Messenger._internal();
    return _instance!;
  }
  static Messenger get instance => Messenger();

  @override
  void connect() => openConnection();

  @override
  void initMsgListener(Function msgHandler) => addPortMessageListener(allowInterop(msgHandler));

  @override
  void sendMsg(String msg) => sendPortMessage(msg);
}
