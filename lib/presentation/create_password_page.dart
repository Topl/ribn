import 'package:flutter/material.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/containers/create_password_container.dart';
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
                      UIConstants.sizedBox,
                      _buildTextField(_enterPasswordController, "New password"),
                      _buildTextField(_confirmPasswordController, "Confirm password"),
                      _buildTermsOfAgreementCheck(),
                      ContinueButton(
                        onPressed: () => vm.attemptCreatePassword(
                          _enterPasswordController.text,
                          _confirmPasswordController.text,
                        ),
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
      padding: const EdgeInsets.symmetric(vertical: UIConstants.generalPadding),
      child: Column(
        children: [
          SizedBox(
            width: UIConstants.loginTextFieldWidth,
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

  Widget _buildTermsOfAgreementCheck() {
    return Container(
      constraints: const BoxConstraints(maxWidth: UIConstants.maxWidth),
      padding: const EdgeInsets.symmetric(vertical: UIConstants.generalPadding),
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
