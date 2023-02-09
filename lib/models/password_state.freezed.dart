// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PasswordState {
  bool get termsOfUseChecked => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get confirmPassword => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PasswordStateCopyWith<PasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordStateCopyWith<$Res> {
  factory $PasswordStateCopyWith(
          PasswordState value, $Res Function(PasswordState) then) =
      _$PasswordStateCopyWithImpl<$Res, PasswordState>;
  @useResult
  $Res call({bool termsOfUseChecked, String password, String confirmPassword});
}

/// @nodoc
class _$PasswordStateCopyWithImpl<$Res, $Val extends PasswordState>
    implements $PasswordStateCopyWith<$Res> {
  _$PasswordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? termsOfUseChecked = null,
    Object? password = null,
    Object? confirmPassword = null,
  }) {
    return _then(_value.copyWith(
      termsOfUseChecked: null == termsOfUseChecked
          ? _value.termsOfUseChecked
          : termsOfUseChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PasswordStateCopyWith<$Res>
    implements $PasswordStateCopyWith<$Res> {
  factory _$$_PasswordStateCopyWith(
          _$_PasswordState value, $Res Function(_$_PasswordState) then) =
      __$$_PasswordStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool termsOfUseChecked, String password, String confirmPassword});
}

/// @nodoc
class __$$_PasswordStateCopyWithImpl<$Res>
    extends _$PasswordStateCopyWithImpl<$Res, _$_PasswordState>
    implements _$$_PasswordStateCopyWith<$Res> {
  __$$_PasswordStateCopyWithImpl(
      _$_PasswordState _value, $Res Function(_$_PasswordState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? termsOfUseChecked = null,
    Object? password = null,
    Object? confirmPassword = null,
  }) {
    return _then(_$_PasswordState(
      termsOfUseChecked: null == termsOfUseChecked
          ? _value.termsOfUseChecked
          : termsOfUseChecked // ignore: cast_nullable_to_non_nullable
              as bool,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_PasswordState extends _PasswordState {
  const _$_PasswordState(
      {this.termsOfUseChecked = false,
      this.password = '',
      this.confirmPassword = ''})
      : super._();

  @override
  @JsonKey()
  final bool termsOfUseChecked;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final String confirmPassword;

  @override
  String toString() {
    return 'PasswordState(termsOfUseChecked: $termsOfUseChecked, password: $password, confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PasswordState &&
            (identical(other.termsOfUseChecked, termsOfUseChecked) ||
                other.termsOfUseChecked == termsOfUseChecked) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, termsOfUseChecked, password, confirmPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PasswordStateCopyWith<_$_PasswordState> get copyWith =>
      __$$_PasswordStateCopyWithImpl<_$_PasswordState>(this, _$identity);
}

abstract class _PasswordState extends PasswordState {
  const factory _PasswordState(
      {final bool termsOfUseChecked,
      final String password,
      final String confirmPassword}) = _$_PasswordState;
  const _PasswordState._() : super._();

  @override
  bool get termsOfUseChecked;
  @override
  String get password;
  @override
  String get confirmPassword;
  @override
  @JsonKey(ignore: true)
  _$$_PasswordStateCopyWith<_$_PasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}
