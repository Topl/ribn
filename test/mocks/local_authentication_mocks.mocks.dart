// Mocks generated by Mockito 5.3.2 from annotations
// in ribn/test/mocks/local_authentication_mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:local_auth/src/local_auth.dart' as _i2;
import 'package:local_auth_android/local_auth_android.dart' as _i4;
import 'package:local_auth_ios/local_auth_ios.dart' as _i5;
import 'package:local_auth_windows/local_auth_windows.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [LocalAuthentication].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalAuthentication extends _i1.Mock
    implements _i2.LocalAuthentication {
  MockLocalAuthentication() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get canCheckBiometrics => (super.noSuchMethod(
        Invocation.getter(#canCheckBiometrics),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<bool> authenticate({
    required String? localizedReason,
    Iterable<_i4.AuthMessages>? authMessages = const [
      _i5.IOSAuthMessages(),
      _i4.AndroidAuthMessages(),
      _i6.WindowsAuthMessages(),
    ],
    _i4.AuthenticationOptions? options = const _i4.AuthenticationOptions(),
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #authenticate,
          [],
          {
            #localizedReason: localizedReason,
            #authMessages: authMessages,
            #options: options,
          },
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<bool> stopAuthentication() => (super.noSuchMethod(
        Invocation.method(
          #stopAuthentication,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<bool> isDeviceSupported() => (super.noSuchMethod(
        Invocation.method(
          #isDeviceSupported,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<List<_i4.BiometricType>> getAvailableBiometrics() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAvailableBiometrics,
          [],
        ),
        returnValue:
            _i3.Future<List<_i4.BiometricType>>.value(<_i4.BiometricType>[]),
      ) as _i3.Future<List<_i4.BiometricType>>);
}
