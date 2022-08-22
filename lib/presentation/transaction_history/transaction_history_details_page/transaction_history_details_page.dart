// ignore_for_file: unused_import

import 'dart:convert';

import 'package:brambldart/brambldart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/constants/assets.dart';
// import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/transaction_history_container.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/models/transaction_history_entry.dart';
import 'package:ribn/presentation/transaction_history/dashed_list_separator/dashed_list_separator.dart';
import 'package:ribn/presentation/transaction_history/transaction_data_row/transaction_data_row.dart';
import 'package:ribn/utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/status_chip.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title.dart';
import 'package:url_launcher/url_launcher.dart';

class TxHistoryDetailsPage extends StatefulWidget {
  final Map? transactionDetails;
  // final AssetDetails assetDetails;
  // final int networkId;

  const TxHistoryDetailsPage({
    required this.transactionDetails,
    // required this.networkId,
    // required this.assetDetails,
    Key? key,
  }) : super(key: key);

  @override
  State<TxHistoryDetailsPage> createState() => _TxHistoryPageDetailsState();
}

class _TxHistoryPageDetailsState extends State<TxHistoryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // print(widget.transactionReceipt!['transactionType']);
    final _scrollController = ScrollController();

    return TransactionHistoryContainer(
      builder: (BuildContext context, TransactionHistoryViewmodel vm) => LoaderOverlay(
        overlayColor: Colors.transparent,
        child: Scaffold(
          backgroundColor: RibnColors.background,
          body: RefreshIndicator(
            backgroundColor: RibnColors.primary,
            color: RibnColors.secondaryDark,
            onRefresh: () async {
              setState(() {});
            },
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    const CustomPageTextTitle(
                      title: Strings.transactionDetails,
                      hideCloseCross: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11.6),
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
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 15,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Transaction Type',
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          widget.transactionDetails!['transactionType'],
                                          style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Timestamp',
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              '${widget.transactionDetails!['timestamp']}',
                                              style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DashedListSeparator(color: RibnColors.lightGreyDivider),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Asset Code',
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 15,
                                              height: 15,
                                              child: widget.transactionDetails?['icon'],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 12),
                                              child: Text(
                                                widget.transactionDetails?['shortName'],
                                                style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Amount',
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              widget.transactionDetails!['transactionAmount'],
                                              style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DashedListSeparator(color: RibnColors.lightGreyDivider),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Status',
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        StatusChip(
                                          status: widget.transactionDetails!['transactionStatus'],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Fee',
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              '-${widget.transactionDetails!['fee']} POLY',
                                              style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DashedListSeparator(color: RibnColors.lightGreyDivider),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'From',
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 26,
                                        height: 26,
                                        child: SvgPicture.asset(RibnAssets.myFingerprint),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          Strings.yourRibnWalletAddress,
                                          style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                        ),
                                      ),
                                      CustomCopyButton(
                                        textToBeCopied: widget.transactionDetails!['myRibnWalletAddress'],
                                        icon: Image.asset(
                                          RibnAssets.copyIcon,
                                          width: 26,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DashedListSeparator(color: RibnColors.lightGreyDivider),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'To',
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 26,
                                        height: 26,
                                        child: SvgPicture.asset(RibnAssets.recipientFingerprint),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          formatAddrString(widget.transactionDetails!['transactionSenderAddress']),
                                          style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                        ),
                                      ),
                                      CustomCopyButton(
                                        textToBeCopied: widget.transactionDetails!['transactionSenderAddress'],
                                        icon: Image.asset(
                                          RibnAssets.copyIcon,
                                          width: 26,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DashedListSeparator(color: RibnColors.lightGreyDivider),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Note',
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          widget.transactionDetails!['note'],
                                          style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DashedListSeparator(color: RibnColors.lightGreyDivider),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 49,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Security root',
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              formatAddrString(
                                                widget.transactionDetails!['securityRoot'],
                                                charsToDisplay: 4,
                                              ),
                                              style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                            ),
                                            CustomCopyButton(
                                              textToBeCopied: widget.transactionDetails!['securityRoot'],
                                              icon: Image.asset(
                                                RibnAssets.copyIcon,
                                                width: 26,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DashedListSeparator(color: RibnColors.lightGreyDivider),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Block ID',
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          '${formatAddrString(
                                            widget.transactionDetails!['blockId'],
                                            charsToDisplay: 4,
                                          )}',
                                          style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Block height',
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              '${widget.transactionDetails!['blockHeight']}',
                                              style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              DashedListSeparator(color: RibnColors.lightGreyDivider),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Transaction ID',
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          '${formatAddrString(
                                            widget.transactionDetails!['transactionId'],
                                            charsToDisplay: 4,
                                          )}',
                                          style: RibnToolkitTextStyles.assetLongNameStyle.copyWith(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'View Topl Explorer',
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            _buildToplExplorerLink()
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Image renderAssetIcon(assetDetailsIcon) {
    return assetDetailsIcon == null
        ? Image.asset(RibnAssets.undefinedIcon)
        : Image.asset(
            assetDetailsIcon!,
          );
  }

  Image renderPolyIcon() {
    return Image.asset(RibnAssets.polyIconCircle);
  }

  /// Redirects user to the Topl Explorer
  RichText _buildToplExplorerLink() {
    // final url = Uri.parse(
    //   '${Rules.txDetailsRedirectUrls[transferDetails.networkId] ?? ''}${transferDetails.transactionId}',
    // );

    final url = Uri.parse(
      '${Rules.txDetailsRedirectUrls[widget.transactionDetails!['networkId']] ?? ''}${widget.transactionDetails!['transactionid']}',
    );

    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: () async => await launchUrl(url),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Strings.viewInToplExplorer,
                    style:
                        RibnToolkitTextStyles.h4.copyWith(fontWeight: FontWeight.w400, color: RibnColors.secondaryDark),
                  ),
                  const SizedBox(width: 5),
                  Image.asset(
                    RibnAssets.openInNewWindow,
                    width: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
