import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget adaptableSpacer() => kIsWeb ? const SizedBox(height: 150) : const Spacer();
Widget renderIfMobile(Widget widget) => kIsWeb ? const SizedBox() : widget;
Widget renderIfWeb(Widget widget) => kIsWeb ? widget : const SizedBox();
