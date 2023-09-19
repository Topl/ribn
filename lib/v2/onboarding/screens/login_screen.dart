// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/screens/asset_managment_screen.dart';
import 'package:ribn/v2/recovery/widgets/modals/restore_access.dart';
import 'package:ribn/v2/shared/constants/assets.dart';
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:ribn/v2/shared/extensions/widget_extensions.dart';
import 'package:ribn/v2/shared/widgets/ribn_button.dart';
import 'package:ribn/v2/user/providers/user_provider.dart';
import 'package:vrouter/vrouter.dart';

/// Builds the login page.
///
/// Prompts the user to unlock their wallet by entering their wallet-locking password.
// ignore: must_be_immutable
class LoginScreen extends ScreenConsumerWidget {
  static const loginPageKey = Key('loginPageKey');
  static const loginPageCreateButtonKey = Key('loginPageCreateButtonKey');
  static const loginPageImportButtonKey = Key('loginPageImportButtonKey');

  LoginScreen({
    Key? key,
  }) : super(key: key, route: '/login');

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPassword = useState(true);
    final userState = ref.read(userProvider.notifier);
    final errorMessage = useState('');

    void validateInput(String value) {
      if (value.isEmpty) {
        errorMessage.value = 'Field cannot be empty';
      } else {
        // Clear the error message if input is valid
        errorMessage.value = '';
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(Assets.ribnLogoIcon, height: 120),
            Spacer(),
            Text(Strings.welcomeToBack, textAlign: TextAlign.left, style: RibnTextStyle.h1),
            SizedBox(height: 20),
            Text(
              Strings.welcomeToRibnSubheader,
              textAlign: TextAlign.left,
              style: RibnTextStyle.h3Grey,
            ),
            SizedBox(height: 30),
            TextField(
              controller: _textEditingController,
              obscureText: showPassword.value,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                suffixIcon: SizedBox(
                  height: 56,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        showPassword.value = !showPassword.value;
                      },
                      child: showPassword.value
                          ? SvgPicture.asset(
                              'assets/v2/icons/visibility_off.svg',
                            )
                          : SvgPicture.asset('assets/v2/icons/visibility.svg'),
                    ),
                  ),
                ),
                hintText: Strings.pin,
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Color(0xFFE2E3E3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: errorMessage.value.isNotEmpty ? RibnColors.redColor : Color(0xFF7040EC),
                  ),
                ),
              ),
              onChanged: (value) {
                validateInput(value);
              },
            ),
            errorMessage.value.isNotEmpty // Check if there's an error message to display
                ? Text(
                    errorMessage.value,
                    style: TextStyle(
                      color: RibnColors.redColor, // You can customize the error text style
                    ),
                  )
                : Container(),
            SizedBox(height: 30),
            RibnButton(
              key: loginPageCreateButtonKey,
              text: Strings.unlock,
              onPressed: () async {
                if (await userState.logUserIn(pin: _textEditingController.text)) {
                  context.vRouter.to(AssetManagementScreen().route);
                } else {
                  errorMessage.value = 'Invalid PIN';
                }
              },
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                key: loginPageImportButtonKey,
                onPressed: () => {
                  RestoreAccess().showAsModal(context),
                },
                child: Text(
                  Strings.importWallet,
                  style: RibnTextStyle.buttonMedium.copyWith(
                    color: RibnColors.defaultText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
