// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/ribn_checkbox_wrappable_text.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title_with_leading_child.dart';

// Project imports:
import 'package:ribn/actions/internal_message_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/presentation/authorize_and_sign/input_dropdown_wrapper.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
import '../../models/internal_message.dart';

class ConnectDApp extends StatefulWidget {
  final InternalMessage request;

  const ConnectDApp(
    this.request, {
    Key? key,
  }) : super(key: key);

  @override
  _ConnectDAppState createState() => _ConnectDAppState();
}

class _ConnectDAppState extends State<ConnectDApp> {
  // final Map mockDAppDetails = {
  //   'logo': RibnAssets.connectDApp,
  //   'name': 'GreenSwap',
  //   'link': 'https://greenswap.com',
  // };

  bool authChecked = false;

  String mockFaviconUrl = '';

  @override
  Widget build(BuildContext context) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            height: 3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            8,
                            8,
                            8,
                            8,
                          ),
                          child: mockFaviconUrl == ''
                              ? Image.asset(
                                  RibnAssets.undefinedIcon,
                                  width: 25,
                                )
                              : Image.network(
                                  mockFaviconUrl,
                                  width: 25,
                                ),
                        ),
                        Text(
                          '${widget.request.data!["name"] ?? widget.request.origin} to access the following:',
                          style: const TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 11,
                            height: 3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(11.6)),
                        color: RibnColors.mediumGrey,
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: RibnCheckboxWrappableText(
                        fillColor: Colors.transparent,
                        checkColor: RibnColors.darkGreen,
                        borderColor: RibnColors.darkGreen,
                        value: authChecked,
                        onChanged: (bool? val) {
                          setState(() {
                            authChecked = val!;
                          });
                        },
                        origin: widget.request.origin,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
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
        sendResponse(context, false);
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
        sendResponse(context, true);
      },
      backgroundColor: RibnColors.primary,
      dropShadowColor: RibnColors.whiteButtonShadow,
      disabled: !authChecked,
    );
  }

  void sendResponse(BuildContext context, bool accept) {
    late final InternalMessage response;

    if (!accept) {
      response = widget.request.copyWith(
        method: InternalMethods.returnResponse,
        sender: InternalMessage.defaultSender,
        data: {
          'enabled': accept,
        },
      );
    } else {
      response = widget.request.copyWith(
        method: InternalMethods.returnResponse,
        sender: InternalMessage.defaultSender,
        data: {
          'enabled': accept,
          'walletAddress': StoreProvider.of<AppState>(context)
              .state
              .keychainState
              .currentNetwork
              .addresses
              .first
              .toplAddress
              .toBase58()
        },
      );
    }
    StoreProvider.of<AppState>(context)
        .dispatch(SendInternalMsgAction(response));
  }
}
