// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/animated_expand_button.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title_with_leading_child.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/raw_tx.dart';
import 'package:ribn/presentation/authorize_and_sign/input_dropdown_wrapper.dart';
import 'package:ribn/presentation/authorize_and_sign/transaction_row_details.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
import 'package:ribn/widgets/fee_info.dart';
import '../../actions/internal_message_actions.dart';
import '../../constants/routes.dart';
import '../../models/app_state.dart';
import '../../models/internal_message.dart';

class ReviewAndSignDApp extends StatefulWidget {
  final InternalMessage request;

  const ReviewAndSignDApp(
    this.request, {
    Key? key,
  }) : super(key: key);

  @override
  _ReviewAndSignDAppState createState() => _ReviewAndSignDAppState();
}

class _ReviewAndSignDAppState extends State<ReviewAndSignDApp> {
  late final Map transactionDetails;
  late final String walletAddress;
  late final RawTx transaction;
  bool isExpanded = false;

  ScrollController _scrollController = ScrollController();

  final TextStyle defaultTextStyle = const TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 11,
    color: RibnColors.defaultText,
  );

  @override
  void initState() {
    transactionDetails = widget.request.data!['rawTx'];
    transaction = RawTx.fromJson(widget.request.data!['rawTx']);

    walletAddress =
        StoreProvider.of<AppState>(context).state.keychainState.currentNetwork.addresses.first.toplAddress.toBase58();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RibnColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomPageTextTitleWithLeadingChild(
              title: Strings.review,
              child: InputDropdownWrapper(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: const Duration(seconds: 1),
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: 360,
                height: isExpanded ? 388 : 228,
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
                child: Wrap(
                  children: [
                    Wrap(
                      children: [
                        Text(
                          Strings.executeTransaction,
                          style: defaultTextStyle.copyWith(height: 3),
                        ),
                        Text(
                          // '${mockDAppDetails['link']}',
                          widget.request.origin,
                          style: defaultTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 12),
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: transactionDetails['to'].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TransactionRowDetails(
                          quantity: transactionDetails['to'][index][1]['quantity'],
                          wasReceivedToMyWallet: transactionDetails['to'][index][0] == walletAddress,
                          isPolyTransfer: transactionDetails['to'][index][1]['type'] == 'Simple',
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedExpandButton(
                          backgroundColor: Colors.transparent,
                          title: 'View txn details',
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          height: 24,
                          width: 139,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                      width: 20,
                    ),
                    Container(
                      height: 137,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(11.6)),
                        color: RibnColors.mediumGrey,
                      ),
                      child: Stack(
                        children: <Widget>[
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: RawScrollbar(
                              shape: const StadiumBorder(),
                              mainAxisMargin: 10,
                              crossAxisMargin: 8,
                              thumbVisibility: true,
                              controller: _scrollController,
                              thumbColor: RibnColors.primary,
                              thickness: 10,
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                child: ListView.builder(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: const EdgeInsets.all(10),
                                  itemCount: 1,
                                  itemBuilder: (buildContext, index) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SelectableText(
                                        // mockDAppTransactionJson,
                                        getPrettyJson(widget.request.data),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: Container(
                              alignment: Alignment.center,
                              width: 27.0,
                              height: 27.0,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: CustomCopyButton(
                                textToBeCopied: getPrettyJson(widget.request.data),
                                bubbleText: 'Copied!',
                                icon: Image.asset(
                                  RibnAssets.copyIconAlternate,
                                  width: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
      bottomNavigationBar: BottomReviewAction(
        maxHeight: kIsWeb ? 127 : 202,
        children: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FeeInfo(fee: int.parse(transactionDetails['fee'])),
            const SizedBox(height: 15),
            kIsWeb
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      renderCancelButton(144),
                      const SizedBox(width: 20),
                      renderConfirmButton(144),
                    ],
                  )
                : Column(
                    children: [
                      renderConfirmButton(double.infinity),
                      const SizedBox(height: 15),
                    ],
                  ),
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
        final InternalMessage response = widget.request.copyWith(
          method: InternalMethods.returnResponse,
          sender: InternalMessage.defaultSender,
          data: {
            'message': 'Request denied',
          },
        );

        StoreProvider.of<AppState>(context).dispatch(SendInternalMsgAction(response));
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
          color: Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(
          context,
          Routes.loadingDApp,
          arguments: widget.request,
        );
      },
      backgroundColor: RibnColors.primary,
      dropShadowColor: RibnColors.whiteButtonShadow,
    );
  }

  String getPrettyJson(dynamic json) {
    final spaces = ' ' * 4;
    final encoder = JsonEncoder.withIndent(spaces);
    return encoder.convert(json);
  }
}
