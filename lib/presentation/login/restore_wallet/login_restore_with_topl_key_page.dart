import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/login/widgets/uploaded_file_container.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_page_title.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

/// This page allows the user to upload their Topl Main Key in order to restore wallet.
///
/// This page is used in the 'restore wallet' flow when initiated from the login page,
/// hence the widget name is prefixed with 'Login'.
class LoginRestoreWithToplKeyPage extends StatefulWidget {
  const LoginRestoreWithToplKeyPage({Key? key}) : super(key: key);

  @override
  _LoginRestoreWithToplKeyPageState createState() => _LoginRestoreWithToplKeyPageState();
}

class _LoginRestoreWithToplKeyPageState extends State<LoginRestoreWithToplKeyPage> {
  /// The name of the file that is uploaded.
  String uploadedFileName = '';

  /// The content of the file that is uploaded.
  String toplKey = '';

  /// True if an error occurs when uploading file.
  bool errorUploadingFile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RibnColors.background,
      body: Column(
        children: [
          const CustomPageTitle(title: Strings.restoreWallet),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 75,
                  width: 309,
                  child: Text(
                    Strings.restoreWalletToplKeyDesc,
                    style: RibnToolkitTextStyles.smallBody.copyWith(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 309,
                  child: Text(
                    Strings.uploadFile,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: RibnColors.defaultText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: _buildFileUploadContainer(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: UploadedFileContainer(uploadedFileName: uploadedFileName),
                ),
                errorUploadingFile
                    ? const Text(
                        'Error Uploading File',
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 17.0),
                  child: LargeButton(
                    buttonChild: Text(
                      Strings.next,
                      style: RibnToolkitTextStyles.btnMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (toplKey.isNotEmpty && !errorUploadingFile) {
                        StoreProvider.of<AppState>(context).dispatch(
                          NavigateToRoute(
                            Routes.loginRestoreWalletEnterPassword,
                            arguments: toplKey,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  /// Builds the file upload container, when pressed, allows the user to upload a key file.
  ///
  /// When a file is selected, [uploadedFileName] is updated with the file name,
  /// and [toplKey] is updated with the [utf8] decoded file content.
  Widget _buildFileUploadContainer() {
    return LargeButton(
      buttonChild: Text(
        Strings.browse,
        style: RibnToolkitTextStyles.btnMedium.copyWith(
          color: Colors.white,
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
}
