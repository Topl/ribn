// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_text_field.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

// Project imports:
import 'package:ribn/v1/actions/user_details_actions.dart';
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/models/app_state.dart';

/// The section for editing asset long anme.
class AssetLongNameEditSection extends StatefulWidget {
  /// The asset code with which the long name will be associated.
  final String assetCode;

  /// A callback function for handling save/cancel actions.
  final VoidCallback onActionTaken;

  // The current asset long name
  final String? currentAssetLongName;

  const AssetLongNameEditSection({
    Key? key,
    required this.assetCode,
    required this.onActionTaken,
    this.currentAssetLongName,
  }) : super(key: key);

  @override
  _AssetLongNameEditSectionState createState() => _AssetLongNameEditSectionState();
}

class _AssetLongNameEditSectionState extends State<AssetLongNameEditSection> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        _controller.text = widget.currentAssetLongName ?? '';
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      width: 307,
      decoration: const BoxDecoration(
        color: RibnColors.whiteBackground,
        boxShadow: [
          BoxShadow(
            color: Color(0x0f000000),
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLongNameTextField(),
          const SizedBox(height: 20),
          Row(
            children: [
              LargeButton(
                buttonWidth: 123,
                buttonHeight: 33,
                buttonChild: Text(
                  'Save',
                  style: RibnToolkitTextStyles.btnMedium.copyWith(color: Colors.white),
                ),
                backgroundColor: RibnColors.primary,
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(
                    UpdateAssetDetailsAction(
                      assetCode: widget.assetCode,
                      longName: _controller.text,
                    ),
                  );
                  widget.onActionTaken();
                },
              ),
              const SizedBox(width: 15),
              LargeButton(
                buttonWidth: 123,
                buttonHeight: 33,
                buttonChild: Text(
                  'Cancel',
                  style: RibnToolkitTextStyles.btnMedium.copyWith(color: RibnColors.ghostButtonText),
                ),
                backgroundColor: Colors.transparent,
                hoverColor: Colors.transparent,
                dropShadowColor: Colors.transparent,
                borderColor: RibnColors.ghostButtonText,
                onPressed: () => widget.onActionTaken(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLongNameTextField() {
    return Material(
      child: CustomTextField(
        controller: _controller,
        hintText: Strings.assetLongNameHint,
        hintColor: RibnColors.hintTextColor,
        width: 268,
        maxLength: 16,
      ),
    );
  }
}
