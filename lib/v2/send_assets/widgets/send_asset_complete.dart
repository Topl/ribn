import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/screens/asset_managment_screen.dart';
import 'package:ribn/v2/send_assets/providers/sending_asset_provider.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/providers/stepper_navigation_control_prover.dart';

import 'package:ribn/v2/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrouter/vrouter.dart';

class SendAssetCompleteScreen extends HookConsumerWidget {
  SendAssetCompleteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nextButtonNotifier = ref.watch(stepperNavigationControlProvider.notifier);
    final sendAsset = ref.watch(sendingAssetProvider.notifier);
    void handleFinish() {

      nextButtonNotifier.setNextButton(true);
      nextButtonNotifier.setDoneButton(true);
      sendAsset.reset();
    }

    useEffect(() {
      Future.delayed(Duration.zero, () {
        handleFinish();
      });
      return () {
        null;
      };
    }, []);

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
            style: headlineLarge(context),
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
                  onPressed: () async {
                    const url = 'https://explore.topl.co/';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    }
                  },
                  child: Text(
                    'See in Annulus Explorer',
                    style: titleSmall(context),
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
                    handleFinish();
                    context.vRouter.to(AssetManagementScreen().route);
                  },
                  child: Text(
                    Strings.close,
                    style: titleSmall(context),
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
