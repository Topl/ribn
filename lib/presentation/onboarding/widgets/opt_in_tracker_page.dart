import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';

class OptInTracker extends HookConsumerWidget {
  static const Key optInTrackerKey = Key('optInTrackerKey');
  const OptInTracker({Key key = optInTrackerKey}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: OnboardingContainer(
        child: Column(
          children: [
            ListView(
              children: [
                _Header(),
                _TopParagraph(),
                _BulletPoints(),
                _ReadMoreSection(),
              ],
            ),
            Row(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.helpUsImprove,
        ),
      ],
    );
  }
}

class _TopParagraph extends StatelessWidget {
  const _TopParagraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.ribnWalletGatherUsage,
        ),
        Text(
          Strings.optOut,
        ),
      ],
    );
  }
}

class _BulletPoints extends StatelessWidget {
  const _BulletPoints({Key? key}) : super(key: key);

  Widget _bulletPoint(String text) {
    return Row(
      children: [
        Text(text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _bulletPoint(Strings.neverCollectKeys),
        _bulletPoint(Strings.neverCollectIP),
        _bulletPoint(Strings.neverSellData),
      ],
    );
  }
}

class _ReadMoreSection extends HookWidget {
  const _ReadMoreSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showReadMore = useState(false);
    return Column(
      children: [
        Row(
          children: [
            Text(
              Strings.readMore,
            ),
            IconButton(
              onPressed: () {
                showReadMore.value = !showReadMore.value;
              },
              icon: Icon(Icons.chevron_left),
            ),
          ],
        ),
      ],
    );
  }
}
