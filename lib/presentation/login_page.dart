import 'package:flutter/material.dart';
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
                    const SizedBox(height: 10),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          SizedBox(
            width: 200,
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
                contentPadding: const EdgeInsets.all(8),
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
        style: TextStyle(fontSize: 11, color: Colors.white),
      ),
      onPressed: () => vm.attemptLogin(password),
    );
  }
}
