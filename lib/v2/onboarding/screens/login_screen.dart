// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/shared/constants/assets.dart';
import 'package:ribn/v2/shared/constants/colors.dart';
import 'package:ribn/v2/shared/constants/ribn_text_style.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:ribn/v2/shared/widgets/ribn_button.dart';

/// Builds the login page.
///
/// Prompts the user to unlock their wallet by entering their wallet-locking password.
class LoginScreen extends ScreenConsumerWidget {
  static const loginPageKey = Key('loginPageKey');
  static const loginPageCreateButtonKey = Key('loginPageCreateButtonKey');
  static const loginPageImportButtonKey = Key('loginPageImportButtonKey');

  LoginScreen({
    Key? key,
  }) : super(key: key, route: '/login');

  TextEditingController _textEditingController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              obscureText: true, // Set this to true for password masking
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                suffixIcon: SizedBox(
                  height: 20,
                  width: 20,
                  child: GestureDetector(
                    onTap: () {},
                    child: obscureText
                        ? SvgPicture.asset('assets/v2/icons/visibility.svg')
                        : SvgPicture.asset('assets/v2/icons/visibility_off.svg'),
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
                    color: Color(0xFF7040EC),
                  ),
                ),
              ),
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(height: 30),
            RibnButton(
              key: loginPageCreateButtonKey,
              text: Strings.unlock,
              onPressed: () {},
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => {},
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
