// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/models/transactions/ribn_activity_details_model.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_copy_button.dart';
import 'package:ribn_toolkit/widgets/atoms/status_chip.dart';
import 'package:ribn_toolkit/widgets/molecules/ribn_activity_details.dart';
import 'package:ribn_toolkit/widgets/organisms/custom_page_text_title.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final dataTileTextStyle = RibnToolkitTextStyles.hintStyle.copyWith(
      fontWeight: FontWeight.w400,
      color: const Color(0xff727372),
    );

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
