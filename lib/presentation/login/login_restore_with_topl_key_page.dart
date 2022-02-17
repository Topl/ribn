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
import 'package:ribn/presentation/login/widgets/next_button.dart';
import 'package:ribn/presentation/login/widgets/restore_page_title.dart';

/// This page allows the user to upload their Topl Key File in order to restore a wallet.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RibnColors.accent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const RestoreWalletPageTitle(currPage: 1),
            const SizedBox(height: 30),
            SizedBox(
              height: 75,
              width: 309,
              child: Text(
                Strings.restoreWalletToplKeyDesc,
                style: RibnTextStyles.smallBody.copyWith(fontSize: 15),
              ),
            ),
            _buildFileUploadContainer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _buildUploadedFileNameContainer(),
            ),
            const Spacer(),
            NextButton(
              onPressed: () {
                if (toplKey.isNotEmpty) {
                  StoreProvider.of<AppState>(context).dispatch(
                    NavigateToRoute(
                      Routes.loginRestoreWalletoldPassword,
                      arguments: toplKey,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the container, when pressed, allows the user to upload a key file.
  ///
  /// When a file is selected, [uploadedFileName] is updated with the file name,
  /// and [toplKey] is updated with the [utf8] decoded content.
  Widget _buildFileUploadContainer() {
    return MaterialButton(
      onPressed: () async {
        final FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          final PlatformFile file = result.files.first;
          setState(() {
            uploadedFileName = file.name;
            toplKey = utf8.decode(file.bytes!);
          });
        }
      },
      child: Container(
        width: 309,
        height: 148,
        color: RibnColors.primary,
        child: const Center(child: Text('Browse')),
      ),
    );
  }

  /// Builds a container to display the [uploadedFileName].
  Widget _buildUploadedFileNameContainer() {
    return uploadedFileName.isNotEmpty
        ? Container(
            width: 309,
            height: 35,
            color: const Color(0xffB1E7E1),
            child: Text(uploadedFileName),
          )
        : const SizedBox();
  }
}