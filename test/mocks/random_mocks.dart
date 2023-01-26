import 'dart:math';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
