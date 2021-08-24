import 'package:flutter/material.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({Key? key})
      : super(
          key: key,
          title: const Text("Ribn"),
          automaticallyImplyLeading: false,
        );
}
