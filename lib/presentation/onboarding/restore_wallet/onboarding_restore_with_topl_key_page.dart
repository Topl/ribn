import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/login/widgets/uploaded_file_container.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

/// This page allows the user to upload their Topl Main Key in order to restore a wallet.
///
/// This page is used in the 'restore wallet' flow when initiated during Onboarding,
/// hence the widget name is prefixed with 'Onboarding'.
class OnboardingRestoreWithToplKeyPage extends StatefulWidget {
  const OnboardingRestoreWithToplKeyPage({Key? key}) : super(key: key);

  @override
  _OnboardingRestoreWithToplKeyPageState createState() => _OnboardingRestoreWithToplKeyPageState();
}

class _OnboardingRestoreWithToplKeyPageState extends State<OnboardingRestoreWithToplKeyPage> {
  final double maxWidth = 754;

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
            SizedBox(
              width: maxWidth,
              child: const Text(
                Strings.restoreWalletToplKeyDesc,
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: maxWidth,
                child: const Text(Strings.uploadFile, style: RibnToolkitTextStyles.extH3),
              ),
            ),
            _buildUploadFileButton(),
            _buildUploadedFileContainer(),
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

  /// Builds the upload file button, when pressed, allows the user to upload a key file.
  ///
  /// When a file is selected, [uploadedFileName] is updated with the file name,
  /// and [toplKey] is updated with the [utf8] decoded file content.
  Widget _buildUploadFileButton() {
    return SizedBox(
      width: maxWidth,
      child: Row(
        children: [
          LargeButton(
            buttonChild: Text(
              Strings.browse,
              style: RibnToolkitTextStyles.btnLarge.copyWith(
                color: RibnColors.ghostButtonText,
              ),
            ),
            backgroundColor: Colors.transparent,
            hoverColor: Colors.transparent,
            dropShadowColor: Colors.transparent,
            borderColor: RibnColors.ghostButtonText,
            buttonWidth: 234,
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
          ),
          const Spacer(),
        ],
      ),
    );
  }

  /// Builds the container to display the uploaded file name.
  Widget _buildUploadedFileContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: maxWidth,
        child: Row(
          children: [
            UploadedFileContainer(uploadedFileName: uploadedFileName, width: 484, height: 46),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  /// Button to continue to the next step.
  Widget _buildContinueButton() {
    return LargeButton(
      buttonChild: Text(
        'Next',
        style: RibnToolkitTextStyles.btnLarge.copyWith(
          color: Colors.white,
        ),
      ),
      backgroundColor: RibnColors.primary,
      hoverColor: RibnColors.primaryButtonHover,
      dropShadowColor: RibnColors.primaryButtonShadow,
      onPressed: () {
        if (toplKey.isNotEmpty && !errorUploadingFile) {
          StoreProvider.of<AppState>(context).dispatch(
            NavigateToRoute(
              Routes.onboardingRestoreWalletEnterPassword,
              arguments: toplKey,
            ),
          );
        }
      },
    );
  }

  /// Builds the page title.
  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 22, bottom: 76),
      child: Text(
        Strings.restoreWallet,
        style: RibnToolkitTextStyles.h1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
