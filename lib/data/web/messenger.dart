// @JS('messenger')
// ignore_for_file: unused_element

@JS()
library messenger;

import 'package:js/js.dart';

// @JS()
// external void sendMessage();
// external void connectToBackground();
// external void addPortMessageListener(Function fn);
// external void sendPortMessage(String data);

// void initPortMessageListener(Function msgHandler) {
//   addPortMessageListener(allowInterop(msgHandler));
// }

@JS()
class Messenger {
  external Messenger();
  external void sendMessage();
  external void connectToBackground();
  external void addPortMessageListener(Function fn);
  external void sendPortMessage(String data);
}

extension Dartify on Messenger {
  void initPortMessageListener(Function msgHandler) => addPortMessageListener(allowInterop(msgHandler));
}
