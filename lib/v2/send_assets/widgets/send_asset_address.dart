import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/send_assets/providers/sending_asset_provider.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:ribn/v2/shared/providers/stepper_screen_provider.dart';
import 'package:ribn/v2/shared/theme.dart';

import 'qr_code_scanner.dart';

class SendAssetsAddressScreen extends HookConsumerWidget {
  const SendAssetsAddressScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepperNotifier = ref.watch(stepperScreenProvider.notifier);
    final sendAsset = ref.watch(sendingAssetProvider.notifier);
    final addressAdded = useState(false);

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
                  Strings.sendAddress,
                  style: bodyMedium(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: SearchBar(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 12),
                  ),
                  trailing: [SvgPicture.asset('assets/v2/icons/icon-copy-outline.svg')],
                  constraints: BoxConstraints(minHeight: 40, minWidth: 120),
                  hintText: Strings.enterAddress,
                  hintStyle: MaterialStateProperty.all(
                    labelLarge(context)?.copyWith(color: Color(0xFFBDBDBD)),
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
                    addressAdded.value = false;
                    sendAsset.updateTo(value);
                    if (value.length > 10) {
                      addressAdded.value = false;
                    }
                  },
                ),
              ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE2E3E3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: IconButton(
                  icon: SvgPicture.asset('assets/v2/icons/scan.svg'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QRViewScanner(),
                    ));
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          addressAdded.value
              ? Text(
                  'Enter address, address has to be more than 10 characters long',
                  style: bodyMedium(context)?.copyWith(
                    color: Color(0xFFE74C3C),
                  ),
                )
              : SizedBox(),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF7040EC).withAlpha(40),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFF7040EC),
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Text(Strings.enterAddressNotification, style: labelMedium(context)),
                )
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
                    if (sendAsset.state.to.length > 10) {
                      stepperNotifier.navigateToPage(context);
                    } else {
                      addressAdded.value = true;
                    }
                  },
                  child: Text(
                    Strings.cont,
                    style: titleSmall(context)?.copyWith(
                      color: Colors.white,
                    ),
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
