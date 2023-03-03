import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_secure_storage_mocks.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
MockFlutterSecureStorage getMockFlutterSecureStorage() {
  final MockFlutterSecureStorage _mock = MockFlutterSecureStorage();

  when(_mock.write(key: anyNamed('key'), value: anyNamed('value')))
      .thenAnswer((realInvocation) async {
    print('QQQQ here 1');
    return;
  });
  when(_mock.read(key: anyNamed('key'))).thenAnswer((realInvocation) async => "");

  return _mock;
}
