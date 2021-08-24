import 'package:flutter/material.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/widgets/base_appbar.dart';
import 'package:ribn/widgets/continue_button.dart';

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
    return Scaffold(
      appBar: BaseAppBar(),
      body: Center(
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
                Keys.navigatorKey.currentState?.pushNamed(Routes.seedPhrase);
              },
              enabled: readTermsOfAgreement,
            ),
          ],
        ),
      ),
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
