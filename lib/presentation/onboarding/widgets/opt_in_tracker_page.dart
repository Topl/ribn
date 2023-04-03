// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/widgets/onboarding_container.dart';
import 'package:ribn/providers/analytics_provider.dart';
import 'package:ribn/utils/url_utils.dart';

class OptInTracker extends HookConsumerWidget {
  static const Key optInTrackerKey = Key('optInTrackerKey');
  static const Key noThanksKey = Key('noThanksKey');
  static const Key iAgreeKey = Key('iAgreeKey');
  static const Key readMoreKey = Key('readMoreKey');
  static const Key privacyPolicyKey = Key('privacyPolicyKey');

  const OptInTracker({Key key = optInTrackerKey}) : super(key: key);

  _handleNoThanks() {
    Keys.navigatorKey.currentState?.pushNamed(Routes.selectAction);
  }

  _handleIAgree(AnalyticsNotifier analyticsNotifier) async {
    await analyticsNotifier.toggleAnalytics(overrideValue: true);
    Keys.navigatorKey.currentState?.pushNamed(Routes.selectAction);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AnalyticsNotifier analyticsNotifier = ref.watch(analyticsProvider.notifier);
    return Scaffold(
      body: OnboardingContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SizedBox(
                width: 700,
                child: ListView(
                  padding: EdgeInsets.only(bottom: 20),
                  children: [
                    _Header(),
                    _TopParagraph(),
                    SizedBox(height: 10),
                    _BulletPoints(),
                    SizedBox(height: 10),
                    _ReadMoreSection(),
                  ],
                ),
              ),
            ),
            _BottomButtons(
              iAgreePressed: () => _handleIAgree(analyticsNotifier),
              noThanksPressed: _handleNoThanks,
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomButtons extends StatelessWidget {
  final void Function() noThanksPressed;
  final void Function() iAgreePressed;
  const _BottomButtons({
    required this.iAgreePressed,
    required this.noThanksPressed,
    Key? key,
  }) : super(key: key);

  List<Widget> _buttons() {
    return [
      LargeButton(
        key: OptInTracker.noThanksKey,
        buttonWidth: kIsWeb ? 220 : 135,
        buttonHeight: 40,
        backgroundColor: Colors.transparent,
        borderColor: kIsWeb ? Colors.transparent : RibnColors.greyOutline,
        dropShadowColor: kIsWeb ? Colors.transparent : RibnColors.primaryButtonShadow,
        hoverColor: kIsWeb ? Colors.transparent : RibnColors.primaryButtonHover,
        onPressed: noThanksPressed,
        buttonChild: Text(
          Strings.noThanks,
          style: RibnToolkitTextStyles.btnMedium.copyWith(color: Colors.white),
        ),
      ),
      LargeButton(
        key: OptInTracker.iAgreeKey,
        buttonWidth: kIsWeb ? 220 : 135,
        buttonHeight: 40,
        backgroundColor: RibnColors.primary,
        dropShadowColor: RibnColors.whiteButtonShadow,
        onPressed: iAgreePressed,
        buttonChild: Text(
          Strings.iAgree,
          style: RibnToolkitTextStyles.btnMedium.copyWith(color: Colors.white),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Container(
            height: 120,
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buttons().reversed.toList(),
            ),
          )
        : Container(
            height: 100,
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buttons(),
            ),
          );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 30,
      ),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: kIsWeb ? MediaQuery.of(context).size.width : 200,
            child: Text(
              Strings.helpUsImprove,
              style: RibnToolkitTextStyles.onboardingH1,
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: RibnColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            width: 50,
            padding: EdgeInsets.only(
              top: 8,
              bottom: 10,
              left: 10,
              right: 8,
            ),
            child: Image.asset(
              RibnAssets.improvePng,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopParagraph extends StatelessWidget {
  const _TopParagraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.ribnWalletGatherUsage,
          style: RibnToolkitTextStyles.onboardingH3,
        ),
        SizedBox(height: 10),
        Text(
          Strings.optOut,
          style: RibnToolkitTextStyles.onboardingH3,
        ),
      ],
    );
  }
}

class _BulletPoints extends StatelessWidget {
  const _BulletPoints({Key? key}) : super(key: key);

  Widget _bulletPoint(String text, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: Image.asset(
              RibnAssets.bulletPointPng,
              height: 11,
            ),
          ),
          Flexible(
            child: Text(
              text,
              style: RibnToolkitTextStyles.onboardingH3,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _bulletPoint(Strings.neverCollectKeys, context),
        _bulletPoint(Strings.neverCollectIP, context),
        _bulletPoint(Strings.neverSellData, context),
      ],
    );
  }
}

class _ReadMoreSection extends HookConsumerWidget {
  const _ReadMoreSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showReadMore = useState(false);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.readMore,
              style: RibnToolkitTextStyles.onboardingH3,
            ),
            IconButton(
              key: OptInTracker.readMoreKey,
              onPressed: () {
                showReadMore.value = !showReadMore.value;
              },
              icon: Icon(showReadMore.value ? Icons.expand_less : Icons.expand_more),
              padding: EdgeInsets.zero,
              iconSize: 30,
              color: Colors.white,
              constraints: BoxConstraints(),
            ),
          ],
        ),
        if (showReadMore.value)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${Strings.readMorePrivacy} ',
                  style: RibnToolkitTextStyles.onboardingH3,
                ),
                TextSpan(
                  text: Strings.privacyPolicyLink,
                  style: RibnToolkitTextStyles.linkText,
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () async {
                      await launchPrivacyPolicyUrl(ref);
                    },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
