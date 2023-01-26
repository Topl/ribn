import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_display_page.dart';
import 'package:ribn/providers/onboarding_provider.dart';

import 'mocks/random_mocks.dart';

goToScreen(WidgetTester tester) async {
  await tester.tap(find.byKey(SeedPhraseDisplayPage.copyKey));
  tester.pump();
  tester.tap(find.byKey(SeedPhraseDisplayPage.copyKey));
  tester.pump();
  tester.tap(find.byKey(SeedPhraseDisplayPage.copyKey));
  tester.tap(find.byKey(SeedPhraseDisplayPage.copyKey));
}

void main() {
  testWidgets('Test test', (WidgetTester tester) async {
    final mockedRandom = getRandomMocks();

    tester.pumpWidget(ProviderScope(
      overrides: [
        randomProvider.overrideWithValue(() => mockedRandom),
      ],
      child: Container(),
    ));
    verifyNever(mockedRandom);

    await goToScreen(tester);

    tester.pump();
    verify(mockedRandom).called(1);
  });
}
