///
//  Generated code. Do not modify.
//  source: types.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class Attestation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Attestation',
      package:
          const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publicKey')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature')
    ..hasRequiredFields = false;

  Attestation._() : super();
  factory Attestation({
    $core.String? publicKey,
    $core.String? signature,
  }) {
    final _result = create();
    if (publicKey != null) {
      _result.publicKey = publicKey;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    return _result;
  }
  factory Attestation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Attestation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  Attestation clone() => Attestation()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  Attestation copyWith(void Function(Attestation) updates) =>
      super.copyWith((message) => updates(message as Attestation)) as Attestation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Attestation create() => Attestation._();
  Attestation createEmptyInstance() => create();
  static $pb.PbList<Attestation> createRepeated() => $pb.PbList<Attestation>();
  @$core.pragma('dart2js:noInline')
  static Attestation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Attestation>(create);
  static Attestation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get publicKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set publicKey($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPublicKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPublicKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get signature => $_getSZ(1);
  @$pb.TagNumber(2)
  set signature($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => clearField(2);
}

class SimpleValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SimpleValue',
      package:
          const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity')
    ..hasRequiredFields = false;

  SimpleValue._() : super();
  factory SimpleValue({
    $core.String? quantity,
  }) {
    final _result = create();
    if (quantity != null) {
      _result.quantity = quantity;
    }
    return _result;
  }
  factory SimpleValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SimpleValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  SimpleValue clone() => SimpleValue()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  SimpleValue copyWith(void Function(SimpleValue) updates) =>
      super.copyWith((message) => updates(message as SimpleValue)) as SimpleValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SimpleValue create() => SimpleValue._();
  SimpleValue createEmptyInstance() => create();
  static $pb.PbList<SimpleValue> createRepeated() => $pb.PbList<SimpleValue>();
  @$core.pragma('dart2js:noInline')
  static SimpleValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SimpleValue>(create);
  static SimpleValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quantity => $_getSZ(0);
  @$pb.TagNumber(1)
  set quantity($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasQuantity() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuantity() => clearField(1);
}

class AssetValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AssetValue',
      package:
          const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'securityRoot')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..hasRequiredFields = false;

  AssetValue._() : super();
  factory AssetValue({
    $core.String? code,
    $core.String? quantity,
    $core.String? securityRoot,
    $core.String? metadata,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    if (securityRoot != null) {
      _result.securityRoot = securityRoot;
    }
    if (metadata != null) {
      _result.metadata = metadata;
    }
    return _result;
  }
  factory AssetValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AssetValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  AssetValue clone() => AssetValue()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  AssetValue copyWith(void Function(AssetValue) updates) =>
      super.copyWith((message) => updates(message as AssetValue)) as AssetValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AssetValue create() => AssetValue._();
  AssetValue createEmptyInstance() => create();
  static $pb.PbList<AssetValue> createRepeated() => $pb.PbList<AssetValue>();
  @$core.pragma('dart2js:noInline')
  static AssetValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssetValue>(create);
  static AssetValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get quantity => $_getSZ(1);
  @$pb.TagNumber(2)
  set quantity($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasQuantity() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuantity() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get securityRoot => $_getSZ(2);
  @$pb.TagNumber(3)
  set securityRoot($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSecurityRoot() => $_has(2);
  @$pb.TagNumber(3)
  void clearSecurityRoot() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => clearField(4);
}

enum TokenValue_Value { simple, asset, notSet }

class TokenValue extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, TokenValue_Value> _TokenValue_ValueByTag = {
    1: TokenValue_Value.simple,
    2: TokenValue_Value.asset,
    0: TokenValue_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TokenValue',
      package:
          const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<SimpleValue>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'simple',
        subBuilder: SimpleValue.create)
    ..aOM<AssetValue>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'asset',
        subBuilder: AssetValue.create)
    ..hasRequiredFields = false;

  TokenValue._() : super();
  factory TokenValue({
    SimpleValue? simple,
    AssetValue? asset,
  }) {
    final _result = create();
    if (simple != null) {
      _result.simple = simple;
    }
    if (asset != null) {
      _result.asset = asset;
    }
    return _result;
  }
  factory TokenValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TokenValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  TokenValue clone() => TokenValue()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  TokenValue copyWith(void Function(TokenValue) updates) =>
      super.copyWith((message) => updates(message as TokenValue)) as TokenValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TokenValue create() => TokenValue._();
  TokenValue createEmptyInstance() => create();
  static $pb.PbList<TokenValue> createRepeated() => $pb.PbList<TokenValue>();
  @$core.pragma('dart2js:noInline')
  static TokenValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenValue>(create);
  static TokenValue? _defaultInstance;

  TokenValue_Value whichValue() => _TokenValue_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  SimpleValue get simple => $_getN(0);
  @$pb.TagNumber(1)
  set simple(SimpleValue v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSimple() => $_has(0);
  @$pb.TagNumber(1)
  void clearSimple() => clearField(1);
  @$pb.TagNumber(1)
  SimpleValue ensureSimple() => $_ensure(0);

  @$pb.TagNumber(2)
  AssetValue get asset => $_getN(1);
  @$pb.TagNumber(2)
  set asset(AssetValue v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasAsset() => $_has(1);
  @$pb.TagNumber(2)
  void clearAsset() => clearField(2);
  @$pb.TagNumber(2)
  AssetValue ensureAsset() => $_ensure(1);
}

class TokenBox extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TokenBox',
      package:
          const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'boxType')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nonce')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'evidence')
    ..aOM<TokenValue>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value',
        subBuilder: TokenValue.create)
    ..hasRequiredFields = false;

  TokenBox._() : super();
  factory TokenBox({
    $core.String? boxType,
    $core.String? id,
    $core.String? nonce,
    $core.String? evidence,
    TokenValue? value,
  }) {
    final _result = create();
    if (boxType != null) {
      _result.boxType = boxType;
    }
    if (id != null) {
      _result.id = id;
    }
    if (nonce != null) {
      _result.nonce = nonce;
    }
    if (evidence != null) {
      _result.evidence = evidence;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory TokenBox.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TokenBox.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  TokenBox clone() => TokenBox()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  TokenBox copyWith(void Function(TokenBox) updates) =>
      super.copyWith((message) => updates(message as TokenBox)) as TokenBox; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TokenBox create() => TokenBox._();
  TokenBox createEmptyInstance() => create();
  static $pb.PbList<TokenBox> createRepeated() => $pb.PbList<TokenBox>();
  @$core.pragma('dart2js:noInline')
  static TokenBox getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenBox>(create);
  static TokenBox? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get boxType => $_getSZ(0);
  @$pb.TagNumber(1)
  set boxType($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBoxType() => $_has(0);
  @$pb.TagNumber(1)
  void clearBoxType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get nonce => $_getSZ(2);
  @$pb.TagNumber(3)
  set nonce($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasNonce() => $_has(2);
  @$pb.TagNumber(3)
  void clearNonce() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get evidence => $_getSZ(3);
  @$pb.TagNumber(4)
  set evidence($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasEvidence() => $_has(3);
  @$pb.TagNumber(4)
  void clearEvidence() => clearField(4);

  @$pb.TagNumber(5)
  TokenValue get value => $_getN(4);
  @$pb.TagNumber(5)
  set value(TokenValue v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearValue() => clearField(5);
  @$pb.TagNumber(5)
  TokenValue ensureValue() => $_ensure(4);
}

class InputBox extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InputBox',
      package:
          const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nonce')
    ..hasRequiredFields = false;

  InputBox._() : super();
  factory InputBox({
    $core.String? address,
    $core.String? nonce,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    if (nonce != null) {
      _result.nonce = nonce;
    }
    return _result;
  }
  factory InputBox.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory InputBox.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  InputBox clone() => InputBox()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  InputBox copyWith(void Function(InputBox) updates) =>
      super.copyWith((message) => updates(message as InputBox)) as InputBox; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InputBox create() => InputBox._();
  InputBox createEmptyInstance() => create();
  static $pb.PbList<InputBox> createRepeated() => $pb.PbList<InputBox>();
  @$core.pragma('dart2js:noInline')
  static InputBox getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InputBox>(create);
  static InputBox? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get nonce => $_getSZ(1);
  @$pb.TagNumber(2)
  set nonce($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNonce() => $_has(1);
  @$pb.TagNumber(2)
  void clearNonce() => clearField(2);
}

class OutputBox extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OutputBox',
      package:
          const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..aOM<TokenValue>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value',
        subBuilder: TokenValue.create)
    ..hasRequiredFields = false;

  OutputBox._() : super();
  factory OutputBox({
    $core.String? address,
    TokenValue? value,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory OutputBox.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OutputBox.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  OutputBox clone() => OutputBox()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  OutputBox copyWith(void Function(OutputBox) updates) =>
      super.copyWith((message) => updates(message as OutputBox)) as OutputBox; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OutputBox create() => OutputBox._();
  OutputBox createEmptyInstance() => create();
  static $pb.PbList<OutputBox> createRepeated() => $pb.PbList<OutputBox>();
  @$core.pragma('dart2js:noInline')
  static OutputBox getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OutputBox>(create);
  static OutputBox? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);

  @$pb.TagNumber(2)
  TokenValue get value => $_getN(1);
  @$pb.TagNumber(2)
  set value(TokenValue v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
  @$pb.TagNumber(2)
  TokenValue ensureValue() => $_ensure(1);
}

class BlockHeight extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockHeight',
      package:
          const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  BlockHeight._() : super();
  factory BlockHeight({
    $fixnum.Int64? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory BlockHeight.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BlockHeight.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  BlockHeight clone() => BlockHeight()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  BlockHeight copyWith(void Function(BlockHeight) updates) =>
      super.copyWith((message) => updates(message as BlockHeight)) as BlockHeight; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockHeight create() => BlockHeight._();
  BlockHeight createEmptyInstance() => create();
  static $pb.PbList<BlockHeight> createRepeated() => $pb.PbList<BlockHeight>();
  @$core.pragma('dart2js:noInline')
  static BlockHeight getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockHeight>(create);
  static BlockHeight? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get value => $_getI64(0);
  @$pb.TagNumber(1)
  set value($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class Transaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Transaction',
      package:
          const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'txType')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..pc<Attestation>(
        3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signatures', $pb.PbFieldType.PM,
        subBuilder: Attestation.create)
    ..pc<TokenBox>(
        4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBoxes', $pb.PbFieldType.PM,
        subBuilder: TokenBox.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data')
    ..pc<InputBox>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputs', $pb.PbFieldType.PM,
        subBuilder: InputBox.create)
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minting')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'txId')
    ..pPS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'boxesToRemove')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee')
    ..pc<OutputBox>(
        11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputs', $pb.PbFieldType.PM,
        subBuilder: OutputBox.create)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'propositionType')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blockId')
    ..a<$fixnum.Int64>(
        14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blockHeight', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  Transaction._() : super();
  factory Transaction({
    $core.String? txType,
    $core.String? timestamp,
    $core.Iterable<Attestation>? signatures,
    $core.Iterable<TokenBox>? newBoxes,
    $core.String? data,
    $core.Iterable<InputBox>? inputs,
    $core.bool? minting,
    $core.String? txId,
    $core.Iterable<$core.String>? boxesToRemove,
    $core.String? fee,
    $core.Iterable<OutputBox>? outputs,
    $core.String? propositionType,
    $core.String? blockId,
    $fixnum.Int64? blockHeight,
  }) {
    final _result = create();
    if (txType != null) {
      _result.txType = txType;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (signatures != null) {
      _result.signatures.addAll(signatures);
    }
    if (newBoxes != null) {
      _result.newBoxes.addAll(newBoxes);
    }
    if (data != null) {
      _result.data = data;
    }
    if (inputs != null) {
      _result.inputs.addAll(inputs);
    }
    if (minting != null) {
      _result.minting = minting;
    }
    if (txId != null) {
      _result.txId = txId;
    }
    if (boxesToRemove != null) {
      _result.boxesToRemove.addAll(boxesToRemove);
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (outputs != null) {
      _result.outputs.addAll(outputs);
    }
    if (propositionType != null) {
      _result.propositionType = propositionType;
    }
    if (blockId != null) {
      _result.blockId = blockId;
    }
    if (blockHeight != null) {
      _result.blockHeight = blockHeight;
    }
    return _result;
  }
  factory Transaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Transaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  Transaction clone() => Transaction()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  Transaction copyWith(void Function(Transaction) updates) =>
      super.copyWith((message) => updates(message as Transaction)) as Transaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Transaction create() => Transaction._();
  Transaction createEmptyInstance() => create();
  static $pb.PbList<Transaction> createRepeated() => $pb.PbList<Transaction>();
  @$core.pragma('dart2js:noInline')
  static Transaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transaction>(create);
  static Transaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get txType => $_getSZ(0);
  @$pb.TagNumber(1)
  set txType($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTxType() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get timestamp => $_getSZ(1);
  @$pb.TagNumber(2)
  set timestamp($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<Attestation> get signatures => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<TokenBox> get newBoxes => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get data => $_getSZ(4);
  @$pb.TagNumber(5)
  set data($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasData() => $_has(4);
  @$pb.TagNumber(5)
  void clearData() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<InputBox> get inputs => $_getList(5);

  @$pb.TagNumber(7)
  $core.bool get minting => $_getBF(6);
  @$pb.TagNumber(7)
  set minting($core.bool v) {
    $_setBool(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasMinting() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinting() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get txId => $_getSZ(7);
  @$pb.TagNumber(8)
  set txId($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasTxId() => $_has(7);
  @$pb.TagNumber(8)
  void clearTxId() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.String> get boxesToRemove => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get fee => $_getSZ(9);
  @$pb.TagNumber(10)
  set fee($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasFee() => $_has(9);
  @$pb.TagNumber(10)
  void clearFee() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<OutputBox> get outputs => $_getList(10);

  @$pb.TagNumber(12)
  $core.String get propositionType => $_getSZ(11);
  @$pb.TagNumber(12)
  set propositionType($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasPropositionType() => $_has(11);
  @$pb.TagNumber(12)
  void clearPropositionType() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get blockId => $_getSZ(12);
  @$pb.TagNumber(13)
  set blockId($core.String v) {
    $_setString(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasBlockId() => $_has(12);
  @$pb.TagNumber(13)
  void clearBlockId() => clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get blockHeight => $_getI64(13);
  @$pb.TagNumber(14)
  set blockHeight($fixnum.Int64 v) {
    $_setInt64(13, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasBlockHeight() => $_has(13);
  @$pb.TagNumber(14)
  void clearBlockHeight() => clearField(14);
}

class Block extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Block',
      package:
          const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parentId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..aOM<TokenBox>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generator',
        subBuilder: TokenBox.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publicKey')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signature')
    ..a<$fixnum.Int64>(
        7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'difficulty')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'txRoot')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bloomFilter')
    ..a<$core.int>(
        11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'version', $pb.PbFieldType.OU3)
    ..a<$core.int>(
        12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'numTransactions', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  Block._() : super();
  factory Block({
    $core.String? id,
    $core.String? parentId,
    $core.String? timestamp,
    TokenBox? generator,
    $core.String? publicKey,
    $core.String? signature,
    $fixnum.Int64? height,
    $core.String? difficulty,
    $core.String? txRoot,
    $core.String? bloomFilter,
    $core.int? version,
    $core.int? numTransactions,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (parentId != null) {
      _result.parentId = parentId;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (generator != null) {
      _result.generator = generator;
    }
    if (publicKey != null) {
      _result.publicKey = publicKey;
    }
    if (signature != null) {
      _result.signature = signature;
    }
    if (height != null) {
      _result.height = height;
    }
    if (difficulty != null) {
      _result.difficulty = difficulty;
    }
    if (txRoot != null) {
      _result.txRoot = txRoot;
    }
    if (bloomFilter != null) {
      _result.bloomFilter = bloomFilter;
    }
    if (version != null) {
      _result.version = version;
    }
    if (numTransactions != null) {
      _result.numTransactions = numTransactions;
    }
    return _result;
  }
  factory Block.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Block.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  Block clone() => Block()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  Block copyWith(void Function(Block) updates) =>
      super.copyWith((message) => updates(message as Block)) as Block; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Block create() => Block._();
  Block createEmptyInstance() => create();
  static $pb.PbList<Block> createRepeated() => $pb.PbList<Block>();
  @$core.pragma('dart2js:noInline')
  static Block getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Block>(create);
  static Block? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get parentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set parentId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasParentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearParentId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);

  @$pb.TagNumber(4)
  TokenBox get generator => $_getN(3);
  @$pb.TagNumber(4)
  set generator(TokenBox v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasGenerator() => $_has(3);
  @$pb.TagNumber(4)
  void clearGenerator() => clearField(4);
  @$pb.TagNumber(4)
  TokenBox ensureGenerator() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get publicKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set publicKey($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPublicKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearPublicKey() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get signature => $_getSZ(5);
  @$pb.TagNumber(6)
  set signature($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSignature() => $_has(5);
  @$pb.TagNumber(6)
  void clearSignature() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get height => $_getI64(6);
  @$pb.TagNumber(7)
  set height($fixnum.Int64 v) {
    $_setInt64(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasHeight() => $_has(6);
  @$pb.TagNumber(7)
  void clearHeight() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get difficulty => $_getSZ(7);
  @$pb.TagNumber(8)
  set difficulty($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasDifficulty() => $_has(7);
  @$pb.TagNumber(8)
  void clearDifficulty() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get txRoot => $_getSZ(8);
  @$pb.TagNumber(9)
  set txRoot($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasTxRoot() => $_has(8);
  @$pb.TagNumber(9)
  void clearTxRoot() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get bloomFilter => $_getSZ(9);
  @$pb.TagNumber(10)
  set bloomFilter($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasBloomFilter() => $_has(9);
  @$pb.TagNumber(10)
  void clearBloomFilter() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get version => $_getIZ(10);
  @$pb.TagNumber(11)
  set version($core.int v) {
    $_setUnsignedInt32(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasVersion() => $_has(10);
  @$pb.TagNumber(11)
  void clearVersion() => clearField(11);

  @$pb.TagNumber(12)
  $core.int get numTransactions => $_getIZ(11);
  @$pb.TagNumber(12)
  set numTransactions($core.int v) {
    $_setUnsignedInt32(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasNumTransactions() => $_has(11);
  @$pb.TagNumber(12)
  void clearNumTransactions() => clearField(12);
}
