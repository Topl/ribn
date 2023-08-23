// Flutter imports:
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/recovery/providers/recovery_provider.dart';
import 'package:ribn/v2/recovery/widgets/recover_input.dart';
import 'package:ribn/v2/shared/theme.dart';

import '../../../v1/constants/strings.dart';

class TypeRecoveryPhrase extends HookConsumerWidget {
  const TypeRecoveryPhrase({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recoveryPhrase = ref.watch(recoveryProvider).recoveryPhrase;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            Strings.typeYourRecoveryPhrase,
            style: headlineLarge(context),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            Strings.typeYourRecoveryPhraseDesc,
            style: bodyMedium(context),
          ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(
                recoveryPhrase.length,
                (index) => RecoveryInput(
                  index: index,
                  value: recoveryPhrase[index],
                  onChanged: (value) {
                    if (value != null && value.isEmpty) value = null;
                    ref.read(recoveryProvider.notifier).updateRecoveryPhrase(
                          index: index,
                          word: value,
                        );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}