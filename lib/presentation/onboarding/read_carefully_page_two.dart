import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/widgets/continue_button.dart';
import 'package:ribn/widgets/custom_tooltip.dart';

/// Builds checks to ensure that the user understands the importance of the wallet password and seed phrase.
class ReadCarefullyPageTwo extends StatefulWidget {
  final Function goToNextPage;
  const ReadCarefullyPageTwo(this.goToNextPage, {Key? key}) : super(key: key);

  @override
  State<ReadCarefullyPageTwo> createState() => _ReadCarefullyPageState();
}

class _ReadCarefullyPageState extends State<ReadCarefullyPageTwo> {
  bool _pointOneChecked = false;
  bool _pointTwoChecked = false;
  bool _pointThreeChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
            width: 315,
            child: Text(
              Strings.readFollowingCarefully,
              style: RibnTextStyles.h1,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35),
            child: SvgPicture.asset(RibnAssets.warningIcon),
          ),
          SizedBox(
            width: 820,
            child: Column(
              children: [
                _buildCheckListTile(
                  Strings.readFollowingCarefullyPointOne,
                  _pointOneChecked,
                  (bool? val) {
                    setState(() {
                      _pointOneChecked = val ?? false;
                    });
                  },
                  false,
                ),
                _buildCheckListTile(
                  Strings.readFollowingCarefullyPointTwo,
                  _pointTwoChecked,
                  (bool? val) {
                    setState(() {
                      _pointTwoChecked = val ?? false;
                    });
                  },
                  false,
                ),
                _buildCheckListTile(Strings.readFollowingCarefullyPointThree, _pointThreeChecked, (bool? val) {
                  setState(() {
                    _pointThreeChecked = val ?? false;
                  });
                }, true),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ContinueButton(
            Strings.iUnderstand,
            () => widget.goToNextPage(),
            disabled: !_pointOneChecked || !_pointTwoChecked || !_pointThreeChecked,
          )
        ],
      ),
    );
  }

  Widget _buildCheckListTile(String label, bool checked, Function(bool?)? onChecked, bool renderTooltipIcon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: checked ? RibnColors.active : RibnColors.inactive),
              ),
              constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
              child: Checkbox(
                fillColor: MaterialStateProperty.all(Colors.transparent),
                checkColor: RibnColors.active,
                value: checked,
                onChanged: onChecked,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: Text(
                label,
                style: RibnTextStyles.body1.copyWith(color: checked ? RibnColors.defaultText : RibnColors.inactive),
                textAlign: TextAlign.start,
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
            ),
          ),
          if (renderTooltipIcon == true)
            CustomToolTip(
              tooltipText: Strings.howIsMySeedPhraseUnrecoverable,
              offsetPositionLeftValue: 450,
              tooltipIcon: SvgPicture.asset(
                RibnAssets.roundInfoCircle,
                width: 24,
                color: checked ? RibnColors.defaultText : RibnColors.inactive,
              ),
              alternateTooltipText: Strings.howIsMySeedPhraseUnrecoverableNewLine,
              tooltipTextBold: true,
              toolTipBackgroundColor: const Color(0xffb1e7e1),
            )
        ],
      ),
    );
  }
}
