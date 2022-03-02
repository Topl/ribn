import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';

/// This page allows the user to upload their Topl Key File in order to restore a wallet.
///
/// This page is used in the 'restore wallet' flow when initiated during Onboarding,
/// hence the widget name is prefixed with 'Onboarding'.
class OnboardingRestoreWithToplKeyPage extends StatefulWidget {
  const OnboardingRestoreWithToplKeyPage({Key? key}) : super(key: key);

  @override
  _OnboardingRestoreWithToplKeyPageState createState() => _OnboardingRestoreWithToplKeyPageState();
}

class _OnboardingRestoreWithToplKeyPageState extends State<OnboardingRestoreWithToplKeyPage> {
  /// The name of the file that is uploaded.
  String uploadedFileName = '';

  /// The content of the file that is uploaded.
  String toplKey = '';

  /// True if an error occurs when uploading file.
  bool errorUploadingFile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            OnboardingAppBar(onBackPressed: () => Navigator.of(context).pop()),
            _buildTitle(),
            const SizedBox(
              width: 734,
              child: Text(
                'First, upload your Top Level Key to import or restore your wallet. Please upload your file in .json format only.',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 15,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: 734,
                child: Text('Upload File', style: RibnTextStyles.extH3),
              ),
            ),
            _buildFileUploadContainer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: _buildUploadedFileNameContainer(),
            ),
            errorUploadingFile
                ? const Text(
                    'Error Uploading File',
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  /// Builds the file upload container, when pressed, allows the user to upload a key file.
  ///
  /// When a file is selected, [uploadedFileName] is updated with the file name,
  /// and [toplKey] is updated with the [utf8] decoded file content.
  Widget _buildFileUploadContainer() {
    return MaterialButton(
      onPressed: () async {
        try {
          final FilePickerResult? result = await FilePicker.platform.pickFiles();
          if (result != null) {
            final PlatformFile file = result.files.first;
            // utf8.decode the file bytes to get the file content as a string
            toplKey = utf8.decode(file.bytes!);
            // validate that the file content can be json decoded
            jsonDecode(toplKey);
            // update the file name
            uploadedFileName = file.name;
            errorUploadingFile = false;
          }
        } catch (e) {
          errorUploadingFile = true;
          uploadedFileName = '';
          toplKey = '';
        }
        setState(() {});
      },
      child: Container(
        width: 734,
        height: 345,
        color: const Color(0xffB1E7E1),
        child: const Center(
          child: Text('Browse'),
        ),
      ),
    );
  }

  /// Builds a container to display the [uploadedFileName].
  Widget _buildUploadedFileNameContainer() {
    return SizedBox(
      width: 734,
      child: Row(
        children: [
          uploadedFileName.isNotEmpty
              ? Container(
                  width: 309,
                  height: 35,
                  color: const Color(0xffB1E7E1),
                  child: Text(uploadedFileName),
                )
              : const SizedBox(height: 35),
          const Spacer(),
        ],
      ),
    );
  }

  /// Button to continue to the next step.
  Widget _buildContinueButton() {
    return MaterialButton(
      color: RibnColors.primary,
      padding: EdgeInsets.zero,
      onPressed: () {
        if (toplKey.isNotEmpty && !errorUploadingFile) {
          StoreProvider.of<AppState>(context).dispatch(
            NavigateToRoute(
              Routes.loginRestoreWalletoldPassword,
              arguments: toplKey,
            ),
          );
        }
      },
      child: const SizedBox(
        width: 234,
        height: 45,
        child: Center(
          child: Text(
            'NEXT',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the page title.
  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 22, bottom: 76),
      child: Text(
        Strings.restoreWallet,
        style: RibnTextStyles.h1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
