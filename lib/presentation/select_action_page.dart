import 'package:flutter/material.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/widgets/base_appbar.dart';

class SelectActionPage extends StatelessWidget {
  const SelectActionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Select action page -- Onboarding page #2"),
            UIConstants.sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton("Create wallet", () {
                  Keys.navigatorKey.currentState?.pushNamed(Routes.createPassword);
                }),
                UIConstants.sizedBox,
                _buildButton("Restore wallet", () {
                  Keys.navigatorKey.currentState?.pushNamed(Routes.createPassword);
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  MaterialButton _buildButton(String text, VoidCallback onPressed) {
    return MaterialButton(
      color: Colors.blue,
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
