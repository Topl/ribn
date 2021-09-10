import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/base_appbar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(_controller, "Password"),
            _buildUnlockButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController textEditingController, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: UIConstants.generalPadding),
      child: Column(
        children: [
          SizedBox(
            width: UIConstants.textFieldSize,
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: label,
                isDense: true,
                contentPadding: const EdgeInsets.all(UIConstants.generalPadding),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockButton(BuildContext context) {
    return MaterialButton(
      color: Colors.blueAccent,
      child: const Text(
        "Unlock",
        style: TextStyle(fontSize: UIConstants.smallTextSize, color: Colors.white),
      ),
      onPressed: () {
        StoreProvider.of<AppState>(context).dispatch(PasswordMismatchAction());
      },
    );
  }
}
