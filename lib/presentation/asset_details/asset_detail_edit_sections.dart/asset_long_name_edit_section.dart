import 'package:flutter/material.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/asset_details/widgets/action_button.dart';
import 'package:ribn/widgets/custom_text_field.dart';

/// The section for editing asset long anme.
class AssetLongNameEditSection extends StatefulWidget {
  /// The asset code with which the long name will be associated.
  final String assetCode;

  /// A callback function for handling save/cancel actions.
  final VoidCallback onActionTaken;

  const AssetLongNameEditSection({
    Key? key,
    required this.assetCode,
    required this.onActionTaken,
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      width: 309,
      decoration: const BoxDecoration(
        color: RibnColors.whiteBackground,
        boxShadow: [BoxShadow(color: Color(0x0f000000), offset: Offset(0, 4), blurRadius: 4, spreadRadius: 0)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLongNameTextField(),
          const SizedBox(height: 20),
          Row(
            children: [
              ActionButton(
                saveChanges: true,
                assetCode: widget.assetCode,
                onPressed: widget.onActionTaken,
                longName: _controller.text,
              ),
              const SizedBox(width: 15),
              ActionButton(
                saveChanges: false,
                assetCode: widget.assetCode,
                onPressed: widget.onActionTaken,
              ),
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
        width: 268,
        maxLength: 16,
      ),
    );
  }
}
