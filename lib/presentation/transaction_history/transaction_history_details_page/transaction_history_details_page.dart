// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
<<<<<<< HEAD
=======
import 'package:flutter_svg/flutter_svg.dart';
>>>>>>> rc-0.4
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/models/transactions/ribn_activity_details_model.dart';
import 'package:ribn_toolkit/widgets/molecules/ribn_activity_details.dart';

// Project imports:

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/transaction_history/dashed_list_separator/dashed_list_separator.dart';
import 'package:ribn/presentation/transaction_history/transaction_history_details_page/transaction_history_data_tile.dart';
import 'package:ribn/utils.dart';

class TxHistoryDetailsPage extends StatefulWidget {
  final RibnActivityDetailsModel ribnActivityDetailsModel;

  const TxHistoryDetailsPage({
    required this.ribnActivityDetailsModel,
    Key? key,
  }) : super(key: key);

  @override
  State<TxHistoryDetailsPage> createState() => _TxHistoryPageDetailsState();
}

class _TxHistoryPageDetailsState extends State<TxHistoryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    return Scaffold(
      backgroundColor: RibnColors.background,
      body: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
<<<<<<< HEAD
          child: RibnActivityDetails(
            activityDetails: widget.ribnActivityDetailsModel,
            dataTileTextStyle: const TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 12,
              color: RibnColors.hintTextColor,
              fontWeight: FontWeight.normal,
            ),
=======
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
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TransactionHistoryDataTile(
                              tileTitle: 'Transaction Type',
                              tileValue: Text(
                                widget.transactionDetails!['transactionType'],
                                style: dataTileTextStyle,
                              ),
                            ),
                            TransactionHistoryDataTile(
                              reducedWidth: true,
                              tileTitle: 'Timestamp',
                              tileValue: Text(
                                widget.transactionDetails!['timestamp'],
                                style: dataTileTextStyle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const DashedListSeparator(
                          color: RibnColors.lightGreyDivider,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TransactionHistoryDataTile(
                              tileTitle: 'Asset Code',
                              tileValue: Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: widget.transactionDetails?['icon'],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text(
                                      widget.transactionDetails?['shortName'],
                                      style: dataTileTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TransactionHistoryDataTile(
                              reducedWidth: true,
                              tileTitle: 'Amount',
                              tileValue: Text(
                                widget.transactionDetails!['transactionAmount'],
                                style: dataTileTextStyle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const DashedListSeparator(
                          color: RibnColors.lightGreyDivider,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TransactionHistoryDataTile(
                              tileTitle: 'Status',
                              tileValue: StatusChip(
                                status: widget
                                    .transactionDetails!['transactionStatus'],
                              ),
                            ),
                            TransactionHistoryDataTile(
                              reducedWidth: true,
                              tileTitle: 'Fee',
                              tileValue: Text(
                                widget.transactionDetails!['fee'].toString(),
                                style: dataTileTextStyle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const DashedListSeparator(
                          color: RibnColors.lightGreyDivider,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TransactionHistoryDataTile(
                          tileTitle: 'To',
                          tileValue: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 26,
                                height: 26,
                                child:
                                    SvgPicture.asset(RibnAssets.myFingerprint),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  Strings.yourRibnWalletAddress,
                                  style: dataTileTextStyle,
                                ),
                              ),
                              CustomCopyButton(
                                textToBeCopied: widget
                                    .transactionDetails!['myRibnWalletAddress'],
                                icon: Image.asset(
                                  RibnAssets.copyIcon,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const DashedListSeparator(
                          color: RibnColors.lightGreyDivider,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TransactionHistoryDataTile(
                          tileTitle: 'From',
                          tileValue: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 26,
                                height: 26,
                                child: SvgPicture.asset(
                                  RibnAssets.recipientFingerprint,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  formatAddrString(
                                    widget.transactionDetails![
                                            'transactionSenderAddress']
                                        .toString(),
                                  ),
                                  style: dataTileTextStyle,
                                ),
                              ),
                              CustomCopyButton(
                                textToBeCopied: widget.transactionDetails![
                                        'transactionSenderAddress']
                                    .toString(),
                                icon: Image.asset(
                                  RibnAssets.copyIcon,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const DashedListSeparator(
                          color: RibnColors.lightGreyDivider,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TransactionHistoryDataTile(
                              tileTitle: 'Note',
                              tileValue: Text(
                                widget.transactionDetails!['note'] ?? '',
                                style: dataTileTextStyle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const DashedListSeparator(
                          color: RibnColors.lightGreyDivider,
                        ),
                        widget.transactionDetails!['securityRoot'] == null
                            ? const SizedBox()
                            : Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TransactionHistoryDataTile(
                                        tileTitle: 'Security Root',
                                        tileValue: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: Text(
                                                formatAddrString(
                                                  widget.transactionDetails![
                                                      'securityRoot'],
                                                  charsToDisplay: 4,
                                                ),
                                                style: dataTileTextStyle,
                                              ),
                                            ),
                                            CustomCopyButton(
                                              textToBeCopied:
                                                  widget.transactionDetails![
                                                      'securityRoot'],
                                              icon: Image.asset(
                                                RibnAssets.copyIcon,
                                                width: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const DashedListSeparator(
                                    color: RibnColors.lightGreyDivider,
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TransactionHistoryDataTile(
                              tileTitle: 'Block ID',
                              tileValue: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      formatAddrString(
                                        widget.transactionDetails!['blockId']
                                            .toString(),
                                        charsToDisplay: 4,
                                      ),
                                      style: dataTileTextStyle,
                                    ),
                                  ),
                                  CustomCopyButton(
                                    textToBeCopied: widget
                                        .transactionDetails!['blockId']
                                        .toString(),
                                    icon: Image.asset(
                                      RibnAssets.copyIcon,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TransactionHistoryDataTile(
                              reducedWidth: true,
                              tileTitle: 'Block height',
                              tileValue: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      widget.transactionDetails!['blockHeight']
                                          .toString(),
                                      style: dataTileTextStyle,
                                    ),
                                  ),
                                  CustomCopyButton(
                                    textToBeCopied: widget
                                        .transactionDetails!['blockHeight']
                                        .toString(),
                                    icon: Image.asset(
                                      RibnAssets.copyIcon,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const DashedListSeparator(
                          color: RibnColors.lightGreyDivider,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TransactionHistoryDataTile(
                              tileTitle: 'Transaction ID',
                              tileValue: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      formatAddrString(
                                        widget.transactionDetails![
                                                'transactionId']
                                            .toString(),
                                        charsToDisplay: 4,
                                      ),
                                      style: dataTileTextStyle,
                                    ),
                                  ),
                                  CustomCopyButton(
                                    textToBeCopied: widget
                                        .transactionDetails!['transactionId']
                                        .toString(),
                                    icon: Image.asset(
                                      RibnAssets.copyIcon,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TransactionHistoryDataTile(
                              reducedWidth: true,
                              tileTitle: 'View Topl Explorer',
                              tileValue: _buildToplExplorerLink(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
>>>>>>> rc-0.4
          ),
        ),
      ),
    );
  }
}
