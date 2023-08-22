// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../v1/constants/strings.dart';
import '../../shared/constants/colors.dart';
import '../../shared/theme.dart';

class RecoveryInput extends HookWidget {
  const RecoveryInput({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    final _controller = useTextEditingController();
    return GridTile(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text("${index + 1}."),
          ),
          Expanded(
            flex: 8,
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
