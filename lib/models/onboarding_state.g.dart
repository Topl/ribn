// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OnboardingState _$$_OnboardingStateFromJson(Map<String, dynamic> json) =>
    _$_OnboardingState(
      mnemonic: json['mnemonic'] as String?,
      shuffledMnemonic: (json['shuffledMnemonic'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      userSelectedIndices: (json['userSelectedIndices'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      mobileConfirmIdxs: (json['mobileConfirmIdxs'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [8, 10, 14, 13],
    );

Map<String, dynamic> _$$_OnboardingStateToJson(_$_OnboardingState instance) =>
    <String, dynamic>{
      'mnemonic': instance.mnemonic,
      'shuffledMnemonic': instance.shuffledMnemonic,
      'userSelectedIndices': instance.userSelectedIndices,
      'mobileConfirmIdxs': instance.mobileConfirmIdxs,
    };
