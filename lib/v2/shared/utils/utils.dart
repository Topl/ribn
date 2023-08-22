// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

Widget adaptableSpacer() => kIsWeb ? const SizedBox(height: 100) : const Spacer();
Widget renderIfMobile(Widget widget) => kIsWeb ? const SizedBox() : widget;
Widget renderIfWeb(Widget widget) => kIsWeb ? widget : const SizedBox();
Widget scrollableIfWeb(Widget child) => kIsWeb ? SingleChildScrollView(child: child) : SizedBox(child: child);

List shuffle(List items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {
    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}
