import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/models/app_state.dart';

/// The advanced option button that allows advanced users to restore their wallet using the Topl Main Key.
class AdvancedOptionButton extends StatefulWidget {
  final String restoreWithToplKeyRoute;
  const AdvancedOptionButton({required this.restoreWithToplKeyRoute, Key? key}) : super(key: key);

  @override
  _AdvancedOptionButtonState createState() => _AdvancedOptionButtonState();
}

class _AdvancedOptionButtonState extends State<AdvancedOptionButton> {
  /// True if advanced option is currently being displayed.
  bool showingAdvancedOption = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MaterialButton(
          onPressed: () {
            setState(() {
              showingAdvancedOption = !showingAdvancedOption;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Strings.advancedOption,
                style: RibnTextStyles.smallBody.copyWith(fontSize: 15),
              ),
              Icon(
                showingAdvancedOption ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up_outlined,
              ),
            ],
          ),
        ),
        showingAdvancedOption
            ? SizedBox(
                width: 137,
                height: 22,
                child: MaterialButton(
                  elevation: 0,
                  color: const Color(0xffB1E7E1),
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(
                      NavigateToRoute(
                        widget.restoreWithToplKeyRoute,
                      ),
                    );
                  },
                  child: Text(
                    Strings.useToplMainKey,
                    style: RibnTextStyles.dropdownButtonStyle.copyWith(fontSize: 11, color: RibnColors.primary),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
