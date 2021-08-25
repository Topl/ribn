import 'package:flutter/material.dart';
import 'package:ribn/widgets/base_appbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
    );
  }
}
