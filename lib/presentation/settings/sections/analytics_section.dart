// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/custom_toggle.dart';

// Project imports:
import 'package:ribn/constants/strings.dart';
import 'package:ribn/providers/analytics/analytics_provider.dart';

class AnalyticsSection extends ConsumerWidget {
  const AnalyticsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.watch(analyticsProvider);
    final notifier = ref.watch(analyticsProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              Strings.participateInAnalytics,
              style: RibnToolkitTextStyles.extH3,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 6, bottom: 8),
              child: Text(
                Strings.participateInAnalyticsDescription,
                style: RibnToolkitTextStyles.settingsSmallText,
              ),
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CustomToggle(
            onChanged: (value) => notifier.toggleAnalytics(),
            value: analytics.isEnabled,
          ),
        ),
      ],
    );
  }
}
