// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/core/constants/colors.dart';
import 'package:ribn/v2/core/constants/ribn_text_style.dart';
import 'package:ribn/v2/core/constants/strings.dart';
import 'package:ribn/v2/view/widgets/ribn_button.dart';

class ErrorModal extends HookConsumerWidget {
  const ErrorModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subTextStyle = RibnTextStyle.h3.copyWith(color: RibnColors.greyText);

    return Container(
      child: Column(
        children: [
          ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child:
                    Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.max, children: [
                  IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.close, color: RibnColors.greyedOut),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(Strings.helpUsImprove,
                      textAlign: TextAlign.left,
                      style: RibnTextStyle.h2.copyWith(
                          // color: RibnColors.lightGreyTitle,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 20),
                  Text(
                    Strings.dataDisclaimerHeader,
                    textAlign: TextAlign.left,
                    style: subTextStyle,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: RibnButton(
                      text: Strings.iAgree,
                      onPressed: () {
                        //TODO: Add Navigation
                      },
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
