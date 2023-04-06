// Dart imports:
import 'dart:math';

// Package imports:
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'random_mocks.mocks.dart';

@GenerateMocks([Random])
MockRandom getRandomMocks() {
  MockRandom _mockRandom = MockRandom();

  when(_mockRandom.nextBool()).thenAnswer((realInvocation) => false);

  return _mockRandom;
}

getBadMock() {
  MockRandom _mockRandom = MockRandom();

  return _mockRandom;
}
