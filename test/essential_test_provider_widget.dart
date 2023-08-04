// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/main.dart';
import 'package:ribn/v1/providers/packages/local_authentication_provider.dart';
import 'package:ribn/v1/providers/store_provider.dart';
import 'mocks/local_authentication_mocks.dart';
import 'mocks/store_mocks.dart';

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    final ByteData data = await load(key);
    return utf8.decode(data.buffer.asUint8List());
  }

  @override
  Future<ByteData> load(String key) async => rootBundle.load(key);
}

Future<void> main({
  List<Override> overrides = const [],
}) async {
  runApp(DefaultAssetBundle(
    bundle: TestAssetBundle(),
    child: await essentialTestProviderWidget(overrides: overrides),
  ));
}

/// The entire application, wrapped in a [ProviderScope].
/// This function exposts a named parameter called [overrides]
/// which is fed forward to the [ProviderScope].
Future<Widget> essentialTestProviderWidget({
  List<Override> overrides = const [],
  MockStore? mockStore,
}) async {
  if (mockStore == null) mockStore = getStoreMocks();
  overrides = [
    localAuthenticationProvider.overrideWithValue(() => getMockLocalAuthentication()),
    storeProvider.overrideWith((ref) => mockStore!),
    ...overrides,
  ];
  WidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultAssetBundle(
        bundle: TestAssetBundle(),
        child: RibnApp(),
      ),
    ),
  );
}

/// This will call [tester.pump] for a duration and loops. Useful for when [pumpAndSettle] is timing out
///
/// Optional Parameters [loops] and [duration can be supplied]
///
/// [loops] is defaulted to 5
///
/// [duration] is defaulted to 0 and is in seconds
Future<void> pumpTester(WidgetTester tester, {int loops = 5, int duration = 0}) async {
  try {
    for (int i = 0; i <= loops; i++) {
      await tester.pump(
        Duration(seconds: duration),
      );
    }
  } catch (e) {
    await tester.pumpAndSettle();
  }
}

/// [delayDuration] is in milliseconds
/// [loopDuration] is in seconds
Future<void> customRunAsync(
  WidgetTester tester, {
  required Future<Null> Function() test,
  int delayDuration = 500,
  int loops = 5,
  int loopDuration = 0,
}) async {
  await tester.runAsync(() async {
    await test();
    await Future.delayed(Duration(milliseconds: delayDuration));
    await pumpTester(
      tester,
      duration: loopDuration,
      loops: loops,
    );
  });
}

// Timers Pending fix
Future<void> pendingTimersFix(WidgetTester tester) async {
  await customRunAsync(tester, test: () async {
    await Future.delayed(Duration(milliseconds: 500));
    await pumpTester(tester, duration: 10, loops: 100);
    await Future.delayed(Duration(milliseconds: 500));
  });
}
