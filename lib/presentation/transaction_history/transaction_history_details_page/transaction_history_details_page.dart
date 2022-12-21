// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/models/transactions/ribn_activity_details_model.dart';
import 'package:ribn_toolkit/widgets/molecules/ribn_activity_details.dart';

// Project imports:

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
            child: RibnActivityDetails(
                activityDetails: widget.ribnActivityDetailsModel,
                dataTileTextStyle: const TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 12,
                  color: RibnColors.hintTextColor,
                  fontWeight: FontWeight.normal,
                ))),
      ),
    );
  }
}
