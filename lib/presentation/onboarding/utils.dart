// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget adaptableSpacer() => kIsWeb ? const SizedBox(height: 100) : const Spacer();
Widget renderIfMobile(Widget widget) => kIsWeb ? const SizedBox() : widget;
Widget renderIfWeb(Widget widget) => kIsWeb ? widget : const SizedBox();
Widget scrollableIfWeb(Widget child) =>
    kIsWeb ? SingleChildScrollView(child: child) : SizedBox(child: child);
