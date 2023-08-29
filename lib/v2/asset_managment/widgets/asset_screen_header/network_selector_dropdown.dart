// Flutter imports:
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/shared/theme.dart';

import '../../models/network.dart';
import '../../providers/selected_network_provider.dart';

class NetworkSelectorDropDown extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNetwork = ref.watch(selectedNetworkNotifierProvider);
    final notifier = ref.watch(selectedNetworkNotifierProvider.notifier);
    final list = notifier.networks();

    return DropdownButton<String>(
      value: selectedNetwork.name,
      icon: const Icon(Icons.expand_more),
      style: bodyMedium(context),
      underline: SizedBox(),
      onChanged: (String? value) {
        notifier.changeKeychain(
          Network.values.firstWhere((element) => element.name == value),
        );
        // dropdownValue = value!;
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
