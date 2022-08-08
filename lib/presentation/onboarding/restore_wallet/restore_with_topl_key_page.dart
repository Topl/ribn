import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/onboarding/utils.dart';
import 'package:ribn/presentation/onboarding/widgets/confirmation_button.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/presentation/onboarding/widgets/uploaded_file_container.dart';
import 'package:ribn/presentation/onboarding/widgets/web_onboarding_app_bar.dart';
import 'package:ribn_toolkit/constants/styles.dart';

/// This page allows the user to upload their Topl Main Key in order to restore a wallet.
///
/// This page is used in the 'restore wallet' flow when initiated during Onboarding,
/// hence the widget name is prefixed with 'Onboarding'.
class RestoreWithToplKeyPage extends StatefulWidget {
  const RestoreWithToplKeyPage({Key? key}) : super(key: key);

  @override
  _RestoreWithToplKeyPageState createState() => _RestoreWithToplKeyPageState();
}

class _RestoreWithToplKeyPageState extends State<RestoreWithToplKeyPage> {
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
      body: OnboardingContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              renderIfWeb(const WebOnboardingAppBar(currStep: 0, numSteps: 2)),
              const Text(
                Strings.restoreWallet,
                style: RibnToolkitTextStyles.onboardingH1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              _buildUploadFileButton(),
              SizedBox(
                height: 150,
                child: uploadedFileName.isNotEmpty ? _buildUploadedFileContainer() : const SizedBox(),
              ),
              errorUploadingFile
                  ? const Text(
                      'Error Uploading File',
                      style: TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
              const SizedBox(height: 30),
              ConfirmationButton(
                text: Strings.next,
                onPressed: () {
                  if (toplKey.isNotEmpty && !errorUploadingFile) {
                    StoreProvider.of<AppState>(context).dispatch(
                      NavigateToRoute(
                        Routes.enterWalletPassword,
                        arguments: toplKey,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the upload file button, when pressed, allows the user to upload a key file.
  ///
  /// When a file is selected, [uploadedFileName] is updated with the file name,
  /// and [toplKey] is updated with the [utf8] decoded file content.
  Widget _buildUploadFileButton() {
    return MaterialButton(
      padding: EdgeInsets.zero,
      child: Container(
        width: 509,
        height: 185,
        color: const Color(0xff979797).withOpacity(0.24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.uploadFile,
              style: RibnToolkitTextStyles.onboardingH3.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 19.5,
              ),
            ),
            const SizedBox(height: 5),
            const Text(Strings.fileUploadLimit, style: RibnToolkitTextStyles.onboardingH3),
            const SizedBox(height: 20),
            Image.asset(RibnAssets.addPlusPng, width: 70),
          ],
        ),
      ),
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
    );
  }

  /// Builds the container to display the uploaded file name.
  Widget _buildUploadedFileContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Uploaded file',
            style: RibnToolkitTextStyles.body1Bold.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 5),
          UploadedFileContainer(uploadedFileName: uploadedFileName, width: 484, height: 46),
        ],
      ),
    );
  }
}
