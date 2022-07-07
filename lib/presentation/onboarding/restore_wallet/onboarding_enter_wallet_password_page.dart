import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/widgets/onboarding_app_bar.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/password_text_field.dart';

/// Allows the user to enter their wallet password to decrypt the Topl Key in [toplKeyStoreJson].
class OnboardingEnterWalletPasswordPage extends StatefulWidget {
  final String toplKeyStoreJson;

  const OnboardingEnterWalletPasswordPage({
    required this.toplKeyStoreJson,
    Key? key,
  }) : super(key: key);

  @override
  _OnboardingEnterWalletPasswordPageState createState() => _OnboardingEnterWalletPasswordPageState();
}

class _OnboardingEnterWalletPasswordPageState extends State<OnboardingEnterWalletPasswordPage> {
  final double maxWidth = 734;
  final TextEditingController _passwordController = TextEditingController();
  bool _failedToRestoreWallet = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

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
                Strings.enterWalletPasswordToRestoreWallet,
              ),
            ),
            // warning section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: _buildReadCarefullySection(),
            ),
            _buildEnterWalletPassword(),
            _failedToRestoreWallet
                ? const Text(
                    'Failed to restore wallet.',
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            LargeButton(
              buttonChild: Text(
                Strings.next,
                style: RibnToolkitTextStyles.btnMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                final Completer<bool> actionCompleter = Completer();
                StoreProvider.of<AppState>(context).dispatch(
                  RestoreWalletWithToplKeyAction(
                    toplKeyStoreJson: widget.toplKeyStoreJson,
                    password: _passwordController.text,
                    completer: actionCompleter,
                  ),
                );
                await actionCompleter.future.then((value) {
                  setState(() {
                    _failedToRestoreWallet = !value;
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnterWalletPassword() {
    return SizedBox(
      width: maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Strings.enterWalletPassword,
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          PasswordTextField(
            controller: _passwordController,
            hintText: Strings.newWalletPasswordHint,
            width: 352,
            icon: SvgPicture.asset(
              _obscurePassword ? RibnAssets.passwordVisibleIon : RibnAssets.passwordHiddenIcon,
              width: 12,
            ),
            obscurePassword: _obscurePassword,
          ),
        ],
      ),
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

  Widget _buildReadCarefullySection() {
    return Container(
      width: 735,
      height: 172,
      color: const Color(0xffE80E00).withOpacity(0.09),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 40, height: 35, child: SvgPicture.asset(RibnAssets.warningIcon)),
                Text(
                  Strings.readCarefully.toUpperCase(),
                  style: const TextStyle(fontFamily: 'DM Sans', fontSize: 28, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 620,
            height: 52,
            child: Text(Strings.restoreWalletReadCarefully),
          )
        ],
      ),
    );
  }
}
