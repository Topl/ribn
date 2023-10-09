import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/send_assets/providers/sending_asset_provider.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/providers/stepper_screen_provider.dart';

import '../../shared/theme.dart';

// ignore: must_be_immutable
class SendTransferAmountScreen extends HookConsumerWidget {
  SendTransferAmountScreen({
    super.key,
  });
  final fullAmount = 4012.0; //TODO: remove this when we have the real amount from the API
  double _amount = 0.00;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepperNotifier = ref.watch(stepperScreenProvider.notifier);
    final sendAsset = ref.watch(sendingAssetProvider.notifier);
    final isAvailableBalance = useState(false);
    final switcher = useState(false);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.send,
            style: headlineLarge(context),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  Strings.sendTransferAmount,
                  style: bodyMedium(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          SearchBar(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 12),
            ),
            trailing: [Text('LVL', style: labelLarge(context)?.copyWith(color: Color(0xFFBDBDBD)))],
            controller: TextEditingController(text: '$_amount'),
            constraints: BoxConstraints(minHeight: 40, minWidth: 120),
            hintText: '0.00',
            hintStyle: MaterialStateProperty.all(
              labelLarge(context),
            ),
            elevation: MaterialStateProperty.all(1),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Color(0xFFE2E3E3),
                ),
              ),
            ),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            onChanged: (value) {
              // has to take only numbers
              _amount = double.parse(value);
              sendAsset.updateAmount(_amount);
              // amount should not be more than fullAmount
              if (_amount > fullAmount) {
                isAvailableBalance.value = true;
              }
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${Strings.totalAvailable}' + ':' + '${fullAmount - sendAsset.state.amount}',
                      style: labelMedium(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        '$fullAmount ${Strings.currencyLVL}',
                        style: labelLarge(context),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      Strings.useMax,
                      style: labelMedium(context),
                    ),
                    Switch(
                      value: switcher.value,
                      onChanged: (bool value) {
                        switcher.value = value;
                        if (value) {
                          _amount = double.parse(fullAmount.toString());
                          sendAsset.updateAmount(_amount);
                        } else {
                          _amount = 0.00;
                        }
                      },
                      activeColor: Color(0xFF0DC8D4), // Customize the active color
                      activeTrackColor: Color(0xFFE2E3E3), // Customize the active track color
                      inactiveThumbColor: Colors.grey, // Customize the inactive thumb color
                      inactiveTrackColor: Color(0xFFE2E3E3), // Customize the inactive track color
                      materialTapTargetSize: MaterialTapTargetSize.padded, // Reduce padding
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    stepperNotifier.navigateToPage(context);
                  },
                  child: Text(
                    Strings.cont,
                    style: labelLarge(context),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0DC8D4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
