import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/recovery/screens/recover_wallet_screen.dart';
import 'package:ribn/v2/shared/theme.dart';
import 'package:ribn/v2/shared/widgets/ribn_button.dart';
import 'package:vrouter/vrouter.dart';

import '../../../../v1/constants/strings.dart';

class RestoreAccess extends ConsumerWidget {
  const RestoreAccess({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF858E8E),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.support_agent,
                  color: Color(0xFF858E8E),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            Strings.restoreAccess,
            style: headlineLarge(context),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            Strings.restoreAccessDescription,
            style: bodyMedium(context),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RibnButton(
                text: Strings.next,
                onPressed: () {
                  context.vRouter.to(RestoreWalletScreen().route);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
