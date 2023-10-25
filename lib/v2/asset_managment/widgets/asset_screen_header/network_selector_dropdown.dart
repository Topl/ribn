// Flutter imports:
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/models/chains.dart';
import 'package:ribn/v2/shared/theme.dart';

import '../../providers/selected_network_provider.dart';

class NetworkSelectorDropDown extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNetwork = ref.watch(selectedChainProvider);
    final chains = ref.watch(chainsProvider);

    return DropdownButton<Chains>(
      value: selectedNetwork,
      icon: const Icon(Icons.expand_more),
      style: bodyMedium(context),
      underline: SizedBox(),
      onChanged: (Chains? value) {
        ref.read(selectedChainProvider.notifier).state = value!;
      },
      items: chains.map<DropdownMenuItem<Chains>>((Chains value) {
        return DropdownMenuItem<Chains>(
          value: value,
          child: Text(value.networkName),
        );
      }).toList(),
    );
  }
}
