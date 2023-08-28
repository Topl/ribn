// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ribn/v2/shared/theme.dart';

final List<String> list = [
  'Toplnet',
  'Valhalla',
  'Private',
];

class NetworkSelectorDropDown extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final dropdownValue = useState(list.first);
    return DropdownButton<String>(
      value: dropdownValue.value,
      icon: const Icon(Icons.expand_more),
      style: bodyMedium(context),
      underline: SizedBox(),
      onChanged: (String? value) {
        dropdownValue.value = value!;
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
