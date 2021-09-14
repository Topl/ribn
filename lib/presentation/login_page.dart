import 'package:flutter/material.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/containers/login_container.dart';
import 'package:ribn/widgets/base_appbar.dart';
import 'package:ribn/widgets/loading_spinner.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();
  String password = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginContainer(
      builder: (context, vm) {
        return Scaffold(
          appBar: BaseAppBar(),
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Login"),
                    _buildTextField(_controller, "Password"),
                    _buildUnlockButton(context, vm, password),
                    UIConstants.sizedBox,
                    vm.incorrectPasswordError
                        ? const Text(
                            "Incorrect password",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              vm.loadingPasswordCheck ? const LoadingSpinner() : const SizedBox()
            ],
          ),
        );
      },
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
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
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

  Widget _buildUnlockButton(BuildContext context, LoginViewModel vm, String password) {
    return MaterialButton(
      color: Colors.blueAccent,
      child: const Text(
        "Unlock",
        style: TextStyle(fontSize: UIConstants.smallTextSize, color: Colors.white),
      ),
      onPressed: () => vm.attemptLogin(password),
    );
  }
}
