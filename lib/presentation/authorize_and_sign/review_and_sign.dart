import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';

import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/authorize_and_sign/input_dropdown_wrapper.dart';
import 'package:ribn/presentation/authorize_and_sign/transaction_row_details.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/animated_expand_button.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title_with_leading_child.dart';

class ReviewAndSignDApp extends StatefulWidget {
  const ReviewAndSignDApp({
    Key? key,
  }) : super(key: key);

  @override
  _ReviewAndSignDAppState createState() => _ReviewAndSignDAppState();
}

class _ReviewAndSignDAppState extends State<ReviewAndSignDApp> {
  String mockMyWalletAddress = '3NPgzD6i71g3xKinh1bVLKQ2Ab4S1kL3Fg3JthUL5ms3YMmfqJm1';
  // '3NQQK6Mgir21QbySoHztQ9hRQoTTnZeBBSw4vUXcVGjKxN5soSQe'

  final Map mockDAppDetails = {
    'logo': RibnAssets.connectDApp,
    'name': 'GreenSwap',
    'link': 'https://greenswap.com',
  };

  final Map mockDAppTransaction = {
    'to': [
      [
        '3NPgzD6i71g3xKinh1bVLKQ2Ab4S1kL3Fg3JthUL5ms3YMmfqJm1',
        {
          'quantity': '100',
          'assetCode': '5YJqb1adQfBmgeCs3pPSajAyazweXxy8hi5TTnCjqwF79kpA6yLa9vZawH',
          'metadata': null,
          'type': 'Asset',
          'securityRoot': '11111111111111111111111111111111'
        }
      ],
      [
        '3NQQK6Mgir21QbySoHztQ9hRQoTTnZeBBSw4vUXcVGjKxN5soSQe',
        {
          'type': 'Simple',
          'quantity': '121',
        }
      ]
    ],
    'from': [
      ['3NPgzD6i71g3xKinh1bVLKQ2Ab4S1kL3Fg3JthUL5ms3YMmfqJm1', '-7628585798404871123']
    ],
    'newBoxes': [
      {
        'nonce': '-7086618909138803055',
        'id': 'FWnRuTTqz9feiEzLWH8u2roiyHhA8sHHuzJ4iSkAvfv2',
        'evidence': '27pbvCBWBgaNmMtKdUnJzgbzTUJnuoG5RqJRztA2ejjEv',
        'type': 'AssetBox',
        'value': {
          'quantity': '199',
          'assetCode': '5YJqb1adQfBmgeCs3pPSajAyazweXxy8hi5TTnCjqwF79kpA6yLa9vZawH',
          'metadata': null,
          'type': 'Asset',
          'securityRoot': '11111111111111111111111111111111'
        },
      }
    ],
    'boxesToRemove': ['GHQYKMWKQwmj3ZyTUk4QgMg12d23NesFTTfRMBfA8qRR'],
    '_id': '63051ae4083b2f0011fa1e69',
    'txType': 'AssetTransfer',
    'timestamp': '1661278926609',
    'signatures': {
      'y1fcEQyQxQEKs82xCSEjiEEzdPcGGQuySzG7VEjDXd6c':
          'GjjWhgJ4J52mZEFDzvdTRnADtXAoe8kPCE1bQ3TKqC6o73U3hM1CsyHGevE1uJjYTaoehnQyu9LergjVg1zBsq47'
    },
    'data': '',
    'minting': false,
    'txId': 's255G4GVscEAC4VABaBKqtoBc2YHCEdo58tqK2K91nmB',
    'fee': '100',
    'propositionType': 'PublicKeyEd25519',
    'block': {'id': '26RnAfCj16ocHGtgq4RpV3VsqQz6chCwLTVv2yJkDBei6', 'height': 4687784},
    '__v': 0
  };

  final String mockDAppTransactionJson = '''{
    'to': [
      [
        '3NPgzD6i71g3xKinh1bVLKQ2Ab4S1kL3Fg3JthUL5ms3YMmfqJm1',
        {
          'quantity': '100',
          'assetCode': '5YJqb1adQfBmgeCs3pPSajAyazweXxy8hi5TTnCjqwF79kpA6yLa9vZawH',
          'metadata': null,
          'type': 'Asset',
          'securityRoot': '11111111111111111111111111111111'
        }
      ],
      [
        '3NQQK6Mgir21QbySoHztQ9hRQoTTnZeBBSw4vUXcVGjKxN5soSQe',
        {
          'type': 'Simple',
          'quantity': '121',
        }
      ]
    ],
    'from': [
      ['3NPgzD6i71g3xKinh1bVLKQ2Ab4S1kL3Fg3JthUL5ms3YMmfqJm1', '-7628585798404871123']
    ],
    'newBoxes': [
      {
        'nonce': '-7086618909138803055',
        'id': 'FWnRuTTqz9feiEzLWH8u2roiyHhA8sHHuzJ4iSkAvfv2',
        'evidence': '27pbvCBWBgaNmMtKdUnJzgbzTUJnuoG5RqJRztA2ejjEv',
        'type': 'AssetBox',
        'value': {
          'quantity': '199',
          'assetCode': '5YJqb1adQfBmgeCs3pPSajAyazweXxy8hi5TTnCjqwF79kpA6yLa9vZawH',
          'metadata': null,
          'type': 'Asset',
          'securityRoot': '11111111111111111111111111111111'
        },
      }
    ],
    'boxesToRemove': ['GHQYKMWKQwmj3ZyTUk4QgMg12d23NesFTTfRMBfA8qRR'],
    '_id': '63051ae4083b2f0011fa1e69',
    'txType': 'AssetTransfer',
    'timestamp': '1661278926609',
    'signatures': {
      'y1fcEQyQxQEKs82xCSEjiEEzdPcGGQuySzG7VEjDXd6c':
          'GjjWhgJ4J52mZEFDzvdTRnADtXAoe8kPCE1bQ3TKqC6o73U3hM1CsyHGevE1uJjYTaoehnQyu9LergjVg1zBsq47'
    },
    'data': '',
    'minting': false,
    'txId': 's255G4GVscEAC4VABaBKqtoBc2YHCEdo58tqK2K91nmB',
    'fee': '100',
    'propositionType': 'PublicKeyEd25519',
    'block': {'id': '26RnAfCj16ocHGtgq4RpV3VsqQz6chCwLTVv2yJkDBei6', 'height': 4687784},
    '__v': 0
  }
  ''';

  bool isExpanded = false;

  final TextStyle defaultTextStyle = const TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 11,
    color: RibnColors.defaultText,
  );

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
            color: Colors.white,
          ),
        ),
        onPressed: () {
          // Confirm auth action will go here
        },
        backgroundColor: RibnColors.primary,
        dropShadowColor: RibnColors.whiteButtonShadow,
      );
    }

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
                height: isExpanded ? 412 : 240,
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
                          'You are about to execute the following transaction on',
                          style: defaultTextStyle.copyWith(height: 3),
                        ),
                        Text(
                          '${mockDAppDetails['link']}',
                          style: defaultTextStyle.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 12),
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: mockDAppTransaction['to'].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TransactionRowDetails(
                          quantity: mockDAppTransaction['to'][index][1]['quantity'],
                          wasReceivedToMyWallet:
                              mockDAppTransaction['to'][index][0] == mockMyWalletAddress ? true : false,
                          isPolyTransfer: mockDAppTransaction['to'][index][1]['type'] == 'Simple' ? true : false,
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
                      height: 26,
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
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: const EdgeInsets.all(10),
                                  itemCount: 1,
                                  itemBuilder: (buildContext, index) {
                                    /// For auto return onto multiple lines
                                    // return Text(
                                    //   mockDAppTransactionJson,
                                    // );

                                    /// For scrolling horizontally
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SelectableText(
                                        mockDAppTransactionJson,
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
                                textToBeCopied: mockDAppTransactionJson,
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
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomReviewAction(
        maxHeight: kIsWeb ? 127 : 202,
        children: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FeeInfo(fee: int.parse(mockDAppTransaction['fee'])),
            const SizedBox(
              height: 15,
            ),
            kIsWeb
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
                      renderConfirmButton(double.infinity),
                      const SizedBox(
                        height: 15,
                      ),
                      renderCancelButton(double.infinity),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
