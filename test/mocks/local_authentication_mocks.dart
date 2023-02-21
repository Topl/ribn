import 'package:local_auth/local_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_authentication_mocks.mocks.dart';

@GenerateMocks([LocalAuthentication])
MockLocalAuthentication getMockLocalAuthentication() {
  final MockLocalAuthentication _mock = MockLocalAuthentication();

  when(_mock.canCheckBiometrics).thenAnswer((realInvocation) async => false);
  when(_mock.isDeviceSupported()).thenAnswer((realInvocation) async => false);

  return _mock;
}
