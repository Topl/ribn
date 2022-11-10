import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/presentation/authorize_and_sign/input_dropdown_wrapper.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
// import 'package:ribn/widgets/ribn_app_bar_wapper.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/checkbox_wrappable_text.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title_with_leading_child.dart';

class ConnectDApp extends StatefulWidget {
  const ConnectDApp({
    Key? key,
  }) : super(key: key);

  @override
  _ConnectDAppState createState() => _ConnectDAppState();
}

class _ConnectDAppState extends State<ConnectDApp> {
  final Map mockDAppDetails = {
    'logo': RibnAssets.connectDApp,
    'name': 'GreenSwap',
    'link': 'https://greenswap.com',
  };

  bool authChecked = false;

  @override
  Widget build(BuildContext context) {
    LargeButton renderCancelButton(buttonWidth) {
      return LargeButton(
        buttonWidth: buttonWidth,
        buttonHeight: 43,
        buttonChild: Text(
          Strings.cancel,
          style: RibnToolkitTextStyles.btnLarge.copyWith(
            color: RibnColors.ghostButtonText,
          ),
        ),
        backgroundColor: Colors.transparent,
        hoverColor: Colors.transparent,
        dropShadowColor: Colors.transparent,
        borderColor: RibnColors.ghostButtonText,
        onPressed: () {
          // Redirect to TBC to go here
        },
      );
    }

    LargeButton renderConfirmButton(buttonWidth) {
      return LargeButton(
        buttonWidth: buttonWidth,
        buttonHeight: 43,
        buttonChild: Text(
          Strings.confirm,
          style: RibnToolkitTextStyles.btnLarge.copyWith(
            color: RibnColors.lightGreyTitle,
          ),
        ),
        onPressed: () {
          // Confirm auth action will go here
        },
        backgroundColor: RibnColors.primary,
        dropShadowColor: RibnColors.whiteButtonShadow,
        disabled: !authChecked,
      );
    }

    return Scaffold(
      backgroundColor: RibnColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomPageTextTitleWithLeadingChild(
              title: Strings.connect,
              child: InputDropdownWrapper(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(11.6)),
                  color: RibnColors.whiteBackground,
                  border: Border.all(color: RibnColors.lightGrey, width: 1),
                  boxShadow: const [
                    BoxShadow(
                      color: RibnColors.greyShadow,
                      spreadRadius: 0,
                      blurRadius: 37.5,
                      offset: Offset(0, -6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Allow',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 11,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Image.asset(
                            RibnAssets.connectDApp,
                            width: 25,
                          ),
                        ),
                        Text(
                          '${mockDAppDetails['name']} to access the following:',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(11.6)),
                        color: RibnColors.mediumGrey,
                      ),
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: CheckboxWrappableText(
                        fillColor: Colors.transparent,
                        checkColor: RibnColors.darkGreen,
                        borderColor: RibnColors.darkGreen,
                        value: authChecked,
                        onChanged: (bool? val) {
                          setState(() {
                            authChecked = val!;
                          });
                        },
                        label: RichText(
                          key: GlobalKey(),
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'I trust ',
                                style: RibnToolkitTextStyles.h3.copyWith(
                                  color: RibnColors.defaultText,
                                  fontSize: 11,
                                ),
                              ),
                              TextSpan(
                                text: '${mockDAppDetails['link']}',
                                style: RibnToolkitTextStyles.h3.copyWith(
                                  color: RibnColors.defaultText,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' and am',
                                style: RibnToolkitTextStyles.h3.copyWith(
                                  color: RibnColors.defaultText,
                                  fontSize: 11,
                                ),
                              ),
                              TextSpan(
                                text: Strings.connectDApp,
                                style: RibnToolkitTextStyles.h3.copyWith(
                                  color: RibnColors.defaultText,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomReviewAction(
        maxHeight: 174,
        children: kIsWeb
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  renderCancelButton(144),
                  const SizedBox(
                    width: 20,
                  ),
                  renderConfirmButton(144),
                ],
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  renderConfirmButton(double.infinity),
                  const SizedBox(
                    height: 15,
                  ),
                  renderCancelButton(double.infinity),
                ],
              ),
      ),
    );
  }
}
