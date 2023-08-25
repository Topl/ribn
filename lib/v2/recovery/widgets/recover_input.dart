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
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final int index;
  final String? value;
  final Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
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
              style: bodyMedium(context),
              onChanged: onChanged,
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
                    color: value != null ? RibnColors.success : Color(0xFFE2E3E3),
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
