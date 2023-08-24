import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/send_assets/providers/send_asset_provider.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/theme.dart';

class SendAssetCompleteScreen extends HookConsumerWidget {
  SendAssetCompleteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(sendAssetProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: Color.fromRGBO(13, 200, 212, 0.04),
                borderRadius: BorderRadius.circular(48),
              ),
              child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.check,
                    color: Color(0xFF0DC8D4),
                  ))),
          SizedBox(height: 20),
          Text(
            'Your transaction completed',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Color(0xFF282A2C),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Everything is perfectly! Sent funds can arrive in a period from a few minutes to a couple of hours.',
                  style: bodyMedium(context),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 6,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // notifier.navigateToPage(context);
                  },
                  child: const Text(
                    'See in Annulus Explorer',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF535757),
                      fontFamily: 'Rational Display',
                      height: 24 / 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE2E3E3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    notifier.finish();
                  },
                  child: const Text(
                    Strings.close,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF535757),
                      fontFamily: 'Rational Display',
                      height: 24 / 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
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
