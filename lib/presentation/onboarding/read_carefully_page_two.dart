import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';
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
  final Map<String, bool> pointsChecked = {
    Strings.readFollowingCarefullyPointOne: false,
    Strings.readFollowingCarefullyPointTwo: false,
    Strings.readFollowingCarefullyPointThree: false,
  };

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
                  label: Strings.readFollowingCarefullyPointOne,
                  checked: pointsChecked[Strings.readFollowingCarefullyPointOne]!,
                  onChecked: (bool? val) => onChecked(val ?? false, Strings.readFollowingCarefullyPointOne),
                ),
                _buildCheckListTile(
                  label: Strings.readFollowingCarefullyPointTwo,
                  checked: pointsChecked[Strings.readFollowingCarefullyPointTwo]!,
                  isActiveText: pointsChecked[Strings.readFollowingCarefullyPointOne]!,
                  onChecked: pointsChecked[Strings.readFollowingCarefullyPointOne]!
                      ? (bool? val) => onChecked(val ?? false, Strings.readFollowingCarefullyPointTwo)
                      : null,
                ),
                _buildCheckListTile(
                  label: Strings.readFollowingCarefullyPointThree,
                  checked: pointsChecked[Strings.readFollowingCarefullyPointThree]!,
                  isActiveText: pointsChecked[Strings.readFollowingCarefullyPointTwo]!,
                  onChecked: pointsChecked[Strings.readFollowingCarefullyPointTwo]!
                      ? (bool? val) => onChecked(val ?? false, Strings.readFollowingCarefullyPointThree)
                      : null,
                  renderTooltipIcon: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ContinueButton(
            Strings.iUnderstand,
            () {
              StoreProvider.of<AppState>(context).dispatch(PersistAppState());
              widget.goToNextPage();
            },
            disabled: pointsChecked.values.contains(false),
          )
        ],
      ),
    );
  }

  void onChecked(bool val, String key) {
    setState(() {
      if (!val) {
        bool shouldUncheck = false;
        pointsChecked.keys.toList().forEach((element) {
          if (element == key) shouldUncheck = true;
          if (shouldUncheck) pointsChecked[element] = false;
        });
      } else {
        pointsChecked[key] = true;
      }
    });
  }

  Widget _buildCheckListTile({
    required String label,
    required bool checked,
    required Function(bool?)? onChecked,
    bool isActiveText = true,
    bool renderTooltipIcon = false,
  }) {
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
                border: Border.all(
                  color: checked ? RibnColors.active : RibnColors.inactive,
                ),
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
                style: RibnTextStyles.body1.copyWith(
                  color: isActiveText ? RibnColors.defaultText : RibnColors.inactive,
                ),
                textAlign: TextAlign.start,
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
            ),
          ),
          if (renderTooltipIcon == true)
            CustomToolTip(
              offsetPositionLeftValue: 450,
              toolTipIcon: Image.asset(
                RibnAssets.roundInfoCircle,
                width: 24,
                color: checked ? RibnColors.defaultText : RibnColors.inactive,
              ),
              toolTipChild: Column(
                children: [
                  Text(
                    Strings.howIsMySeedPhraseUnrecoverable,
                    style: RibnTextStyles.toolTipTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    Strings.howIsMySeedPhraseUnrecoverableNewLine,
                    style: RibnTextStyles.toolTipTextStyle,
                  )
                ],
              ),
              toolTipBackgroundColor: const Color(0xffb1e7e1),
            )
        ],
      ),
    );
  }
}
