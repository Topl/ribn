import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn/widgets/continue_button.dart';
import 'package:ribn_toolkit/widgets/molecules/custom_tooltip.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_checkbox.dart';

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
              style: RibnToolkitTextStyles.h1,
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
                _buildCheckListTile(
                  Strings.readFollowingCarefullyPointThree,
                  _pointThreeChecked,
                  (bool? val) {
                    setState(() {
                      _pointThreeChecked = val ?? false;
                    });
                  },
                  true,
                ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCheckbox(
          fillColor: MaterialStateProperty.all(Colors.transparent),
          checkColor: RibnColors.active,
          borderColor: checked ? RibnColors.defaultText : RibnColors.inactive,
          value: checked,
          onChanged: onChecked,
          label: Row(
            children: [
              Text(
                label,
                style:
                    RibnToolkitTextStyles.body1.copyWith(color: checked ? RibnColors.defaultText : RibnColors.inactive),
                textAlign: TextAlign.start,
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
              if (renderTooltipIcon == true)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: CustomToolTip(
                    offsetPositionLeftValue: 400,
                    toolTipIcon: Image.asset(
                      RibnAssets.greyHelpBubble,
                      width: 18,
                      color: checked ? RibnColors.defaultText : RibnColors.inactive,
                    ),
                    toolTipChild: Column(
                      children: [
                        Text(
                          Strings.howIsMySeedPhraseUnrecoverable,
                          style: RibnToolkitTextStyles.toolTipTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          Strings.howIsMySeedPhraseUnrecoverableNewLine,
                          style: RibnToolkitTextStyles.toolTipTextStyle,
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
