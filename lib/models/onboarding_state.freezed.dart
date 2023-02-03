// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OnboardingState _$OnboardingStateFromJson(Map<String, dynamic> json) {
  return _OnboardingState.fromJson(json);
}

/// @nodoc
mixin _$OnboardingState {
  String get mnemonic => throw _privateConstructorUsedError;
  List<String> get shuffledMnemonic => throw _privateConstructorUsedError;
  List<int>? get userSelectedIndices => throw _privateConstructorUsedError;
  List<int> get mobileConfirmIdxs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnboardingStateCopyWith<OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
          OnboardingState value, $Res Function(OnboardingState) then) =
      _$OnboardingStateCopyWithImpl<$Res, OnboardingState>;
  @useResult
  $Res call(
      {String mnemonic,
      List<String> shuffledMnemonic,
      List<int>? userSelectedIndices,
      List<int> mobileConfirmIdxs});
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res, $Val extends OnboardingState>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mnemonic = null,
    Object? shuffledMnemonic = null,
    Object? userSelectedIndices = freezed,
    Object? mobileConfirmIdxs = null,
  }) {
    return _then(_value.copyWith(
      mnemonic: null == mnemonic
          ? _value.mnemonic
          : mnemonic // ignore: cast_nullable_to_non_nullable
              as String,
      shuffledMnemonic: null == shuffledMnemonic
          ? _value.shuffledMnemonic
          : shuffledMnemonic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userSelectedIndices: freezed == userSelectedIndices
          ? _value.userSelectedIndices
          : userSelectedIndices // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      mobileConfirmIdxs: null == mobileConfirmIdxs
          ? _value.mobileConfirmIdxs
          : mobileConfirmIdxs // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OnboardingStateCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$$_OnboardingStateCopyWith(
          _$_OnboardingState value, $Res Function(_$_OnboardingState) then) =
      __$$_OnboardingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String mnemonic,
      List<String> shuffledMnemonic,
      List<int>? userSelectedIndices,
      List<int> mobileConfirmIdxs});
}

/// @nodoc
class __$$_OnboardingStateCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$_OnboardingState>
    implements _$$_OnboardingStateCopyWith<$Res> {
  __$$_OnboardingStateCopyWithImpl(
      _$_OnboardingState _value, $Res Function(_$_OnboardingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mnemonic = null,
    Object? shuffledMnemonic = null,
    Object? userSelectedIndices = freezed,
    Object? mobileConfirmIdxs = null,
  }) {
    return _then(_$_OnboardingState(
      mnemonic: null == mnemonic
          ? _value.mnemonic
          : mnemonic // ignore: cast_nullable_to_non_nullable
              as String,
      shuffledMnemonic: null == shuffledMnemonic
          ? _value._shuffledMnemonic
          : shuffledMnemonic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userSelectedIndices: freezed == userSelectedIndices
          ? _value._userSelectedIndices
          : userSelectedIndices // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      mobileConfirmIdxs: null == mobileConfirmIdxs
          ? _value._mobileConfirmIdxs
          : mobileConfirmIdxs // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OnboardingState
    with DiagnosticableTreeMixin
    implements _OnboardingState {
  const _$_OnboardingState(
      {required this.mnemonic,
      required final List<String> shuffledMnemonic,
      final List<int>? userSelectedIndices,
      final List<int> mobileConfirmIdxs = const [8, 10, 14, 13]})
      : _shuffledMnemonic = shuffledMnemonic,
        _userSelectedIndices = userSelectedIndices,
        _mobileConfirmIdxs = mobileConfirmIdxs;

  factory _$_OnboardingState.fromJson(Map<String, dynamic> json) =>
      _$$_OnboardingStateFromJson(json);

  @override
  final String mnemonic;
  final List<String> _shuffledMnemonic;
  @override
  List<String> get shuffledMnemonic {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shuffledMnemonic);
  }

  final List<int>? _userSelectedIndices;
  @override
  List<int>? get userSelectedIndices {
    final value = _userSelectedIndices;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int> _mobileConfirmIdxs;
  @override
  @JsonKey()
  List<int> get mobileConfirmIdxs {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mobileConfirmIdxs);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OnboardingState(mnemonic: $mnemonic, shuffledMnemonic: $shuffledMnemonic, userSelectedIndices: $userSelectedIndices, mobileConfirmIdxs: $mobileConfirmIdxs)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OnboardingState'))
      ..add(DiagnosticsProperty('mnemonic', mnemonic))
      ..add(DiagnosticsProperty('shuffledMnemonic', shuffledMnemonic))
      ..add(DiagnosticsProperty('userSelectedIndices', userSelectedIndices))
      ..add(DiagnosticsProperty('mobileConfirmIdxs', mobileConfirmIdxs));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnboardingState &&
            (identical(other.mnemonic, mnemonic) ||
                other.mnemonic == mnemonic) &&
            const DeepCollectionEquality()
                .equals(other._shuffledMnemonic, _shuffledMnemonic) &&
            const DeepCollectionEquality()
                .equals(other._userSelectedIndices, _userSelectedIndices) &&
            const DeepCollectionEquality()
                .equals(other._mobileConfirmIdxs, _mobileConfirmIdxs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      mnemonic,
      const DeepCollectionEquality().hash(_shuffledMnemonic),
      const DeepCollectionEquality().hash(_userSelectedIndices),
      const DeepCollectionEquality().hash(_mobileConfirmIdxs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OnboardingStateCopyWith<_$_OnboardingState> get copyWith =>
      __$$_OnboardingStateCopyWithImpl<_$_OnboardingState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OnboardingStateToJson(
      this,
    );
  }
}

abstract class _OnboardingState implements OnboardingState {
  const factory _OnboardingState(
      {required final String mnemonic,
      required final List<String> shuffledMnemonic,
      final List<int>? userSelectedIndices,
      final List<int> mobileConfirmIdxs}) = _$_OnboardingState;

  factory _OnboardingState.fromJson(Map<String, dynamic> json) =
      _$_OnboardingState.fromJson;

  @override
  String get mnemonic;
  @override
  List<String> get shuffledMnemonic;
  @override
  List<int>? get userSelectedIndices;
  @override
  List<int> get mobileConfirmIdxs;
  @override
  @JsonKey(ignore: true)
  _$$_OnboardingStateCopyWith<_$_OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}
