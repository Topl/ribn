import 'package:ribn/platform/interfaces.dart';

class Messenger implements MessengerI {
  Messenger._internal();
  static Messenger? _instance;
  factory Messenger() {
    _instance ??= Messenger._internal();
    return _instance!;
  }
  static Messenger get instance => Messenger();

  @override
  void connect() async {
    throw UnimplementedError();
  }

  @override
  void initMsgListener(Function fn) {
    throw UnimplementedError();
  }

  @override
  void sendMsg(String msg) {
    throw UnimplementedError();
  }
}
