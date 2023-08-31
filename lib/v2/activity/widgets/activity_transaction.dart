import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/theme.dart';

class ActivityTransaction extends HookWidget {
  const ActivityTransaction(
      {super.key,
      required this.transactionName,
      required this.transactionDateTime,
      required this.transactionAmountLVL,
      required this.transactionType,
      this.transactionAmountUSD});

  final String transactionName;
  final String transactionDateTime;
  final String transactionAmountLVL;
  final String? transactionAmountUSD;
  final String transactionType;

  static String Function(dynamic transactionType) getIconToDisplay = (transactionType) {
    switch (transactionType) {
      case 'received':
        return 'assets/v2/icons/received.svg';
      case 'sent':
        return 'assets/v2/icons/sent.svg';
      case 'fees':
        return 'assets/v2/icons/fees.svg';
      default:
        return 'assets/v2/icons/fees.svg';
    }
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Color(0xFFE2E3E3),
                  ),
                ),
                child: IconButton(
                  icon: SvgPicture.asset(getIconToDisplay(transactionType)),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transactionName, style: titleSmall(context)),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      transactionDateTime,
                      style: labelSmall(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: (transactionAmountUSD!.isEmpty || transactionAmountLVL.isEmpty) ? 8.0 : 0),
                      child: Text(
                        // ignore: todo
                        /** TODO: write a function to manage the currency based on the transaction name  */
                        '$transactionAmountLVL ${transactionName == 'Ethereum' ? Strings.currencyETH : Strings.currencyLVL}',
                        style: TextStyle(
                            color: (transactionAmountUSD!.contains('-') || transactionAmountLVL.contains('-'))
                                ? Color(0xFFEB5757)
                                : Color(0xFF27AE60),
                            fontSize: titleSmall(context)?.fontSize,
                            fontFamily: titleSmall(context)?.fontFamily,
                            fontWeight: titleSmall(context)?.fontWeight),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '$transactionAmountUSD  ${Strings.currencyUSD}',
                      style: labelSmall(context),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ],
      ),
    );
  }
}
