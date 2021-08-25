import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/containers/create_password_container.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/base_appbar.dart';
import 'package:ribn/widgets/continue_button.dart';
import 'package:ribn/widgets/loading_spinner.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({Key? key}) : super(key: key);

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  bool readTermsOfAgreement = false;
  final TextEditingController _enterPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreatePasswordContainer(
      builder: (context, vm) {
        return Scaffold(
          appBar: BaseAppBar(),
          body: Center(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Create Password Page -- Onboarding page #3"),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildTextField(_enterPasswordController, "New password"),
                      _buildTextField(_confirmPasswordController, "Confirm password"),
                      _buildTermsOfAgreementCheck(),
                      ContinueButton(
                        onPressed: () {
                          StoreProvider.of<AppState>(context).dispatch(
                            CreatePasswordAction(
                                _enterPasswordController.text, _confirmPasswordController.text),
                          );
                        },
                        enabled: readTermsOfAgreement,
                      ),
                      vm.passwordMismatchError
                          ? const Text(
                              "Passwords don't match",
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox(),
                      vm.passwordTooShortError
                          ? const Text(
                              "Passwords must be at least 8 characters",
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                vm.loadingPasswordValidation ? const LoadingSpinner() : const SizedBox(),
              ],
            ),
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
            width: 300,
            child: TextField(
              controller: textEditingController,
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

  Widget _buildTermsOfAgreementCheck() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CheckboxListTile(
        title: const Text("I have read and agree to the Terms"),
        value: readTermsOfAgreement,
        onChanged: (isChecked) {
          setState(() {
            readTermsOfAgreement = isChecked ?? false;
          });
        },
      ),
    );
  }
}
