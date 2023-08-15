// Flutter imports:
import 'package:flutter/material.dart';

import '../../../v1/constants/strings.dart';
import '../../shared/constants/colors.dart';
import '../../shared/theme.dart';

class RecoveryInput extends StatefulWidget {
  const RecoveryInput({super.key, required this.index});

  final int index;

  @override
  State<RecoveryInput> createState() => _RecoveryInputState();
}

class _RecoveryInputState extends State<RecoveryInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text("${widget.index + 1}."),
          ),
          Flexible(
            child: TextFormField(
              controller: _controller,
              style: bodyMedium(context),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: RibnColors.primary,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: RibnColors.error,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: _controller.text.toString() == 'test' ? RibnColors.success : Color(0xFFE2E3E3),
                  ),
                ),
                hintText: Strings.typeWord,
              ),
            ),
          )
        ],
      ),
    );
  }
}
