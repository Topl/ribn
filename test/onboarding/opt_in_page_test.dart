import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/presentation/onboarding/create_wallet/select_action_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/welcome_page.dart';
import 'package:ribn/presentation/onboarding/widgets/opt_in_tracker_page.dart';
import 'package:ribn/providers/packages/url_launcher_provider.dart';

import '../essential_test_provider_widget.dart';
import '../mocks/store_mocks.dart';
import '../utils/text_utils.dart';

void main() {
  testWidgets('Clicking No Thanks Brings you to the next page', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(10000, 10000);
    await tester.pumpWidget(
      await essentialTestProviderWidget(
        overrides: [],
        mockStore: getStoreMocks(isNewUser: true),
      ),
    );

    /// Welcome Page Section
    expect(find.byKey(WelcomePage.welcomePageKey), findsOneWidget);
    await tester.tap(find.byKey(WelcomePage.welcomePageConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Opt In
    expect(find.byKey(OptInTracker.optInTrackerKey), findsOneWidget);
    await tester.tap(find.byKey(OptInTracker.noThanksKey));
    await tester.pumpAndSettle();

    /// Expect next page
    expect(find.byKey(SelectActionPage.selectActionPageKey), findsOneWidget);
  });

  testWidgets('Clicking I Agree Brings you to the next page and inits analytics',
      (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(10000, 10000);
    await tester.pumpWidget(
      await essentialTestProviderWidget(
        overrides: [],
        mockStore: getStoreMocks(isNewUser: true),
      ),
    );

    /// Welcome Page Section
    expect(find.byKey(WelcomePage.welcomePageKey), findsOneWidget);
    await tester.tap(find.byKey(WelcomePage.welcomePageConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Opt In
    expect(find.byKey(OptInTracker.optInTrackerKey), findsOneWidget);
    await tester.tap(find.byKey(OptInTracker.iAgreeKey));
    await tester.pumpAndSettle();

    // TODO: Implement check for opt in

    /// Expect next page
    expect(find.byKey(SelectActionPage.selectActionPageKey), findsOneWidget);
  });

  testWidgets('Clicking Read more and privacy policy works', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(10000, 10000);

    bool clicked = false;
    await tester.pumpWidget(
      await essentialTestProviderWidget(
        overrides: [
          urlLauncherProvider.overrideWithValue((p0) async {
            clicked = true;
            return true;
          })
        ],
        mockStore: getStoreMocks(isNewUser: true),
      ),
    );

    /// Welcome Page Section
    expect(find.byKey(WelcomePage.welcomePageKey), findsOneWidget);
    await tester.tap(find.byKey(WelcomePage.welcomePageConfirmationButtonKey));
    await tester.pumpAndSettle();

    /// Opt In
    expect(clicked, false);
    expect(find.byKey(OptInTracker.optInTrackerKey), findsOneWidget);
    // Expect no privacy policy yet
    final finder = find.byWidgetPredicate(
      (widget) => widget is RichText && tapTextSpan(widget, Strings.privacyPolicyLink),
    );
    expect(find.text(Strings.privacyPolicyLink), findsNothing);
    await tester.tap(find.byKey(OptInTracker.readMoreKey));
    await tester.pumpAndSettle();
    expect(find.text(Strings.privacyPolicyLink), findsOneWidget);
    expect(clicked, true);
  });
}
