///
//  Generated code. Do not modify.
//  source: filters.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class StringSelection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StringSelection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'values')
    ..hasRequiredFields = false
  ;

  StringSelection._() : super();
  factory StringSelection({
    $core.Iterable<$core.String>? values,
  }) {
    final _result = create();
    if (values != null) {
      _result.values.addAll(values);
    }
    return _result;
  }
  factory StringSelection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StringSelection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StringSelection clone() => StringSelection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StringSelection copyWith(void Function(StringSelection) updates) => super.copyWith((message) => updates(message as StringSelection)) as StringSelection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StringSelection create() => StringSelection._();
  StringSelection createEmptyInstance() => create();
  static $pb.PbList<StringSelection> createRepeated() => $pb.PbList<StringSelection>();
  @$core.pragma('dart2js:noInline')
  static StringSelection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StringSelection>(create);
  static StringSelection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get values => $_getList(0);
}

enum NumberRange_FilterType {
  min, 
  max, 
  notSet
}

class NumberRange extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, NumberRange_FilterType> _NumberRange_FilterTypeByTag = {
    1 : NumberRange_FilterType.min,
    2 : NumberRange_FilterType.max,
    0 : NumberRange_FilterType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NumberRange', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'min', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'max', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  NumberRange._() : super();
  factory NumberRange({
    $fixnum.Int64? min,
    $fixnum.Int64? max,
  }) {
    final _result = create();
    if (min != null) {
      _result.min = min;
    }
    if (max != null) {
      _result.max = max;
    }
    return _result;
  }
  factory NumberRange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NumberRange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NumberRange clone() => NumberRange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NumberRange copyWith(void Function(NumberRange) updates) => super.copyWith((message) => updates(message as NumberRange)) as NumberRange; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NumberRange create() => NumberRange._();
  NumberRange createEmptyInstance() => create();
  static $pb.PbList<NumberRange> createRepeated() => $pb.PbList<NumberRange>();
  @$core.pragma('dart2js:noInline')
  static NumberRange getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NumberRange>(create);
  static NumberRange? _defaultInstance;

  NumberRange_FilterType whichFilterType() => _NumberRange_FilterTypeByTag[$_whichOneof(0)]!;
  void clearFilterType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $fixnum.Int64 get min => $_getI64(0);
  @$pb.TagNumber(1)
  set min($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMin() => $_has(0);
  @$pb.TagNumber(1)
  void clearMin() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get max => $_getI64(1);
  @$pb.TagNumber(2)
  set max($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMax() => $_has(1);
  @$pb.TagNumber(2)
  void clearMax() => clearField(2);
}

class NumberSelection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NumberSelection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'values', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false
  ;

  NumberSelection._() : super();
  factory NumberSelection({
    $core.Iterable<$fixnum.Int64>? values,
  }) {
    final _result = create();
    if (values != null) {
      _result.values.addAll(values);
    }
    return _result;
  }
  factory NumberSelection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NumberSelection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NumberSelection clone() => NumberSelection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NumberSelection copyWith(void Function(NumberSelection) updates) => super.copyWith((message) => updates(message as NumberSelection)) as NumberSelection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NumberSelection create() => NumberSelection._();
  NumberSelection createEmptyInstance() => create();
  static $pb.PbList<NumberSelection> createRepeated() => $pb.PbList<NumberSelection>();
  @$core.pragma('dart2js:noInline')
  static NumberSelection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NumberSelection>(create);
  static NumberSelection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$fixnum.Int64> get values => $_getList(0);
}

class BooleanSelection extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BooleanSelection', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..hasRequiredFields = false
  ;

  BooleanSelection._() : super();
  factory BooleanSelection({
    $core.bool? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory BooleanSelection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BooleanSelection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BooleanSelection clone() => BooleanSelection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BooleanSelection copyWith(void Function(BooleanSelection) updates) => super.copyWith((message) => updates(message as BooleanSelection)) as BooleanSelection; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BooleanSelection create() => BooleanSelection._();
  BooleanSelection createEmptyInstance() => create();
  static $pb.PbList<BooleanSelection> createRepeated() => $pb.PbList<BooleanSelection>();
  @$core.pragma('dart2js:noInline')
  static BooleanSelection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BooleanSelection>(create);
  static BooleanSelection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get value => $_getBF(0);
  @$pb.TagNumber(1)
  set value($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

enum TokenValueFilter_FilterType {
  assetCodeSelection, 
  quantityRange, 
  tokenValueTypeSelection, 
  notSet
}

class TokenValueFilter extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, TokenValueFilter_FilterType> _TokenValueFilter_FilterTypeByTag = {
    1 : TokenValueFilter_FilterType.assetCodeSelection,
    2 : TokenValueFilter_FilterType.quantityRange,
    3 : TokenValueFilter_FilterType.tokenValueTypeSelection,
    0 : TokenValueFilter_FilterType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TokenValueFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<StringSelection>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'assetCodeSelection', subBuilder: StringSelection.create)
    ..aOM<NumberRange>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantityRange', subBuilder: NumberRange.create)
    ..aOM<StringSelection>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tokenValueTypeSelection', subBuilder: StringSelection.create)
    ..hasRequiredFields = false
  ;

  TokenValueFilter._() : super();
  factory TokenValueFilter({
    StringSelection? assetCodeSelection,
    NumberRange? quantityRange,
    StringSelection? tokenValueTypeSelection,
  }) {
    final _result = create();
    if (assetCodeSelection != null) {
      _result.assetCodeSelection = assetCodeSelection;
    }
    if (quantityRange != null) {
      _result.quantityRange = quantityRange;
    }
    if (tokenValueTypeSelection != null) {
      _result.tokenValueTypeSelection = tokenValueTypeSelection;
    }
    return _result;
  }
  factory TokenValueFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenValueFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenValueFilter clone() => TokenValueFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenValueFilter copyWith(void Function(TokenValueFilter) updates) => super.copyWith((message) => updates(message as TokenValueFilter)) as TokenValueFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TokenValueFilter create() => TokenValueFilter._();
  TokenValueFilter createEmptyInstance() => create();
  static $pb.PbList<TokenValueFilter> createRepeated() => $pb.PbList<TokenValueFilter>();
  @$core.pragma('dart2js:noInline')
  static TokenValueFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenValueFilter>(create);
  static TokenValueFilter? _defaultInstance;

  TokenValueFilter_FilterType whichFilterType() => _TokenValueFilter_FilterTypeByTag[$_whichOneof(0)]!;
  void clearFilterType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  StringSelection get assetCodeSelection => $_getN(0);
  @$pb.TagNumber(1)
  set assetCodeSelection(StringSelection v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAssetCodeSelection() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetCodeSelection() => clearField(1);
  @$pb.TagNumber(1)
  StringSelection ensureAssetCodeSelection() => $_ensure(0);

  @$pb.TagNumber(2)
  NumberRange get quantityRange => $_getN(1);
  @$pb.TagNumber(2)
  set quantityRange(NumberRange v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuantityRange() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuantityRange() => clearField(2);
  @$pb.TagNumber(2)
  NumberRange ensureQuantityRange() => $_ensure(1);

  @$pb.TagNumber(3)
  StringSelection get tokenValueTypeSelection => $_getN(2);
  @$pb.TagNumber(3)
  set tokenValueTypeSelection(StringSelection v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTokenValueTypeSelection() => $_has(2);
  @$pb.TagNumber(3)
  void clearTokenValueTypeSelection() => clearField(3);
  @$pb.TagNumber(3)
  StringSelection ensureTokenValueTypeSelection() => $_ensure(2);
}

class TransactionFilter_AndFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionFilter.AndFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..pc<TransactionFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filters', $pb.PbFieldType.PM, subBuilder: TransactionFilter.create)
    ..hasRequiredFields = false
  ;

  TransactionFilter_AndFilter._() : super();
  factory TransactionFilter_AndFilter({
    $core.Iterable<TransactionFilter>? filters,
  }) {
    final _result = create();
    if (filters != null) {
      _result.filters.addAll(filters);
    }
    return _result;
  }
  factory TransactionFilter_AndFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionFilter_AndFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionFilter_AndFilter clone() => TransactionFilter_AndFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionFilter_AndFilter copyWith(void Function(TransactionFilter_AndFilter) updates) => super.copyWith((message) => updates(message as TransactionFilter_AndFilter)) as TransactionFilter_AndFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionFilter_AndFilter create() => TransactionFilter_AndFilter._();
  TransactionFilter_AndFilter createEmptyInstance() => create();
  static $pb.PbList<TransactionFilter_AndFilter> createRepeated() => $pb.PbList<TransactionFilter_AndFilter>();
  @$core.pragma('dart2js:noInline')
  static TransactionFilter_AndFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionFilter_AndFilter>(create);
  static TransactionFilter_AndFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TransactionFilter> get filters => $_getList(0);
}

class TransactionFilter_OrFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionFilter.OrFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..pc<TransactionFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filters', $pb.PbFieldType.PM, subBuilder: TransactionFilter.create)
    ..hasRequiredFields = false
  ;

  TransactionFilter_OrFilter._() : super();
  factory TransactionFilter_OrFilter({
    $core.Iterable<TransactionFilter>? filters,
  }) {
    final _result = create();
    if (filters != null) {
      _result.filters.addAll(filters);
    }
    return _result;
  }
  factory TransactionFilter_OrFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionFilter_OrFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionFilter_OrFilter clone() => TransactionFilter_OrFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionFilter_OrFilter copyWith(void Function(TransactionFilter_OrFilter) updates) => super.copyWith((message) => updates(message as TransactionFilter_OrFilter)) as TransactionFilter_OrFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionFilter_OrFilter create() => TransactionFilter_OrFilter._();
  TransactionFilter_OrFilter createEmptyInstance() => create();
  static $pb.PbList<TransactionFilter_OrFilter> createRepeated() => $pb.PbList<TransactionFilter_OrFilter>();
  @$core.pragma('dart2js:noInline')
  static TransactionFilter_OrFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionFilter_OrFilter>(create);
  static TransactionFilter_OrFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TransactionFilter> get filters => $_getList(0);
}

class TransactionFilter_NotFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionFilter.NotFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..aOM<TransactionFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter', subBuilder: TransactionFilter.create)
    ..hasRequiredFields = false
  ;

  TransactionFilter_NotFilter._() : super();
  factory TransactionFilter_NotFilter({
    TransactionFilter? filter,
  }) {
    final _result = create();
    if (filter != null) {
      _result.filter = filter;
    }
    return _result;
  }
  factory TransactionFilter_NotFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionFilter_NotFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionFilter_NotFilter clone() => TransactionFilter_NotFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionFilter_NotFilter copyWith(void Function(TransactionFilter_NotFilter) updates) => super.copyWith((message) => updates(message as TransactionFilter_NotFilter)) as TransactionFilter_NotFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionFilter_NotFilter create() => TransactionFilter_NotFilter._();
  TransactionFilter_NotFilter createEmptyInstance() => create();
  static $pb.PbList<TransactionFilter_NotFilter> createRepeated() => $pb.PbList<TransactionFilter_NotFilter>();
  @$core.pragma('dart2js:noInline')
  static TransactionFilter_NotFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionFilter_NotFilter>(create);
  static TransactionFilter_NotFilter? _defaultInstance;

  @$pb.TagNumber(1)
  TransactionFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter(TransactionFilter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  TransactionFilter ensureFilter() => $_ensure(0);
}

class TransactionFilter_AllFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionFilter.AllFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  TransactionFilter_AllFilter._() : super();
  factory TransactionFilter_AllFilter() => create();
  factory TransactionFilter_AllFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionFilter_AllFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionFilter_AllFilter clone() => TransactionFilter_AllFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionFilter_AllFilter copyWith(void Function(TransactionFilter_AllFilter) updates) => super.copyWith((message) => updates(message as TransactionFilter_AllFilter)) as TransactionFilter_AllFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionFilter_AllFilter create() => TransactionFilter_AllFilter._();
  TransactionFilter_AllFilter createEmptyInstance() => create();
  static $pb.PbList<TransactionFilter_AllFilter> createRepeated() => $pb.PbList<TransactionFilter_AllFilter>();
  @$core.pragma('dart2js:noInline')
  static TransactionFilter_AllFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionFilter_AllFilter>(create);
  static TransactionFilter_AllFilter? _defaultInstance;
}

enum TransactionFilter_FilterType {
  txTypeSelection, 
  timestampRange, 
  inputAddressSelection, 
  inputNonceSelection, 
  outputTokenBoxTypeSelection, 
  outputTokenValueFilter, 
  outputAddressSelection, 
  mintingSelection, 
  txIdSelection, 
  boxesToRemoveSelection, 
  feeRange, 
  propositionSelection, 
  blockIdSelection, 
  blockHeightRange, 
  and, 
  or, 
  not, 
  all, 
  notSet
}

class TransactionFilter extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, TransactionFilter_FilterType> _TransactionFilter_FilterTypeByTag = {
    1 : TransactionFilter_FilterType.txTypeSelection,
    2 : TransactionFilter_FilterType.timestampRange,
    3 : TransactionFilter_FilterType.inputAddressSelection,
    4 : TransactionFilter_FilterType.inputNonceSelection,
    5 : TransactionFilter_FilterType.outputTokenBoxTypeSelection,
    6 : TransactionFilter_FilterType.outputTokenValueFilter,
    7 : TransactionFilter_FilterType.outputAddressSelection,
    8 : TransactionFilter_FilterType.mintingSelection,
    9 : TransactionFilter_FilterType.txIdSelection,
    10 : TransactionFilter_FilterType.boxesToRemoveSelection,
    11 : TransactionFilter_FilterType.feeRange,
    12 : TransactionFilter_FilterType.propositionSelection,
    13 : TransactionFilter_FilterType.blockIdSelection,
    14 : TransactionFilter_FilterType.blockHeightRange,
    15 : TransactionFilter_FilterType.and,
    16 : TransactionFilter_FilterType.or,
    17 : TransactionFilter_FilterType.not,
    18 : TransactionFilter_FilterType.all,
    0 : TransactionFilter_FilterType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18])
    ..aOM<StringSelection>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'txTypeSelection', subBuilder: StringSelection.create)
    ..aOM<NumberRange>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestampRange', subBuilder: NumberRange.create)
    ..aOM<StringSelection>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputAddressSelection', subBuilder: StringSelection.create)
    ..aOM<NumberSelection>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inputNonceSelection', subBuilder: NumberSelection.create)
    ..aOM<StringSelection>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputTokenBoxTypeSelection', subBuilder: StringSelection.create)
    ..aOM<TokenValueFilter>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputTokenValueFilter', subBuilder: TokenValueFilter.create)
    ..aOM<StringSelection>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputAddressSelection', subBuilder: StringSelection.create)
    ..aOM<BooleanSelection>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mintingSelection', subBuilder: BooleanSelection.create)
    ..aOM<StringSelection>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'txIdSelection', subBuilder: StringSelection.create)
    ..aOM<StringSelection>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'boxesToRemoveSelection', subBuilder: StringSelection.create)
    ..aOM<NumberRange>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feeRange', subBuilder: NumberRange.create)
    ..aOM<StringSelection>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'propositionSelection', subBuilder: StringSelection.create)
    ..aOM<StringSelection>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blockIdSelection', subBuilder: StringSelection.create)
    ..aOM<NumberRange>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blockHeightRange', subBuilder: NumberRange.create)
    ..aOM<TransactionFilter_AndFilter>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'and', subBuilder: TransactionFilter_AndFilter.create)
    ..aOM<TransactionFilter_OrFilter>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'or', subBuilder: TransactionFilter_OrFilter.create)
    ..aOM<TransactionFilter_NotFilter>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'not', subBuilder: TransactionFilter_NotFilter.create)
    ..aOM<TransactionFilter_AllFilter>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'all', subBuilder: TransactionFilter_AllFilter.create)
    ..hasRequiredFields = false
  ;

  TransactionFilter._() : super();
  factory TransactionFilter({
    StringSelection? txTypeSelection,
    NumberRange? timestampRange,
    StringSelection? inputAddressSelection,
    NumberSelection? inputNonceSelection,
    StringSelection? outputTokenBoxTypeSelection,
    TokenValueFilter? outputTokenValueFilter,
    StringSelection? outputAddressSelection,
    BooleanSelection? mintingSelection,
    StringSelection? txIdSelection,
    StringSelection? boxesToRemoveSelection,
    NumberRange? feeRange,
    StringSelection? propositionSelection,
    StringSelection? blockIdSelection,
    NumberRange? blockHeightRange,
    TransactionFilter_AndFilter? and,
    TransactionFilter_OrFilter? or,
    TransactionFilter_NotFilter? not,
    TransactionFilter_AllFilter? all,
  }) {
    final _result = create();
    if (txTypeSelection != null) {
      _result.txTypeSelection = txTypeSelection;
    }
    if (timestampRange != null) {
      _result.timestampRange = timestampRange;
    }
    if (inputAddressSelection != null) {
      _result.inputAddressSelection = inputAddressSelection;
    }
    if (inputNonceSelection != null) {
      _result.inputNonceSelection = inputNonceSelection;
    }
    if (outputTokenBoxTypeSelection != null) {
      _result.outputTokenBoxTypeSelection = outputTokenBoxTypeSelection;
    }
    if (outputTokenValueFilter != null) {
      _result.outputTokenValueFilter = outputTokenValueFilter;
    }
    if (outputAddressSelection != null) {
      _result.outputAddressSelection = outputAddressSelection;
    }
    if (mintingSelection != null) {
      _result.mintingSelection = mintingSelection;
    }
    if (txIdSelection != null) {
      _result.txIdSelection = txIdSelection;
    }
    if (boxesToRemoveSelection != null) {
      _result.boxesToRemoveSelection = boxesToRemoveSelection;
    }
    if (feeRange != null) {
      _result.feeRange = feeRange;
    }
    if (propositionSelection != null) {
      _result.propositionSelection = propositionSelection;
    }
    if (blockIdSelection != null) {
      _result.blockIdSelection = blockIdSelection;
    }
    if (blockHeightRange != null) {
      _result.blockHeightRange = blockHeightRange;
    }
    if (and != null) {
      _result.and = and;
    }
    if (or != null) {
      _result.or = or;
    }
    if (not != null) {
      _result.not = not;
    }
    if (all != null) {
      _result.all = all;
    }
    return _result;
  }
  factory TransactionFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionFilter clone() => TransactionFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionFilter copyWith(void Function(TransactionFilter) updates) => super.copyWith((message) => updates(message as TransactionFilter)) as TransactionFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionFilter create() => TransactionFilter._();
  TransactionFilter createEmptyInstance() => create();
  static $pb.PbList<TransactionFilter> createRepeated() => $pb.PbList<TransactionFilter>();
  @$core.pragma('dart2js:noInline')
  static TransactionFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionFilter>(create);
  static TransactionFilter? _defaultInstance;

  TransactionFilter_FilterType whichFilterType() => _TransactionFilter_FilterTypeByTag[$_whichOneof(0)]!;
  void clearFilterType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  StringSelection get txTypeSelection => $_getN(0);
  @$pb.TagNumber(1)
  set txTypeSelection(StringSelection v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxTypeSelection() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxTypeSelection() => clearField(1);
  @$pb.TagNumber(1)
  StringSelection ensureTxTypeSelection() => $_ensure(0);

  @$pb.TagNumber(2)
  NumberRange get timestampRange => $_getN(1);
  @$pb.TagNumber(2)
  set timestampRange(NumberRange v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimestampRange() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestampRange() => clearField(2);
  @$pb.TagNumber(2)
  NumberRange ensureTimestampRange() => $_ensure(1);

  @$pb.TagNumber(3)
  StringSelection get inputAddressSelection => $_getN(2);
  @$pb.TagNumber(3)
  set inputAddressSelection(StringSelection v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasInputAddressSelection() => $_has(2);
  @$pb.TagNumber(3)
  void clearInputAddressSelection() => clearField(3);
  @$pb.TagNumber(3)
  StringSelection ensureInputAddressSelection() => $_ensure(2);

  @$pb.TagNumber(4)
  NumberSelection get inputNonceSelection => $_getN(3);
  @$pb.TagNumber(4)
  set inputNonceSelection(NumberSelection v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasInputNonceSelection() => $_has(3);
  @$pb.TagNumber(4)
  void clearInputNonceSelection() => clearField(4);
  @$pb.TagNumber(4)
  NumberSelection ensureInputNonceSelection() => $_ensure(3);

  @$pb.TagNumber(5)
  StringSelection get outputTokenBoxTypeSelection => $_getN(4);
  @$pb.TagNumber(5)
  set outputTokenBoxTypeSelection(StringSelection v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasOutputTokenBoxTypeSelection() => $_has(4);
  @$pb.TagNumber(5)
  void clearOutputTokenBoxTypeSelection() => clearField(5);
  @$pb.TagNumber(5)
  StringSelection ensureOutputTokenBoxTypeSelection() => $_ensure(4);

  @$pb.TagNumber(6)
  TokenValueFilter get outputTokenValueFilter => $_getN(5);
  @$pb.TagNumber(6)
  set outputTokenValueFilter(TokenValueFilter v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasOutputTokenValueFilter() => $_has(5);
  @$pb.TagNumber(6)
  void clearOutputTokenValueFilter() => clearField(6);
  @$pb.TagNumber(6)
  TokenValueFilter ensureOutputTokenValueFilter() => $_ensure(5);

  @$pb.TagNumber(7)
  StringSelection get outputAddressSelection => $_getN(6);
  @$pb.TagNumber(7)
  set outputAddressSelection(StringSelection v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasOutputAddressSelection() => $_has(6);
  @$pb.TagNumber(7)
  void clearOutputAddressSelection() => clearField(7);
  @$pb.TagNumber(7)
  StringSelection ensureOutputAddressSelection() => $_ensure(6);

  @$pb.TagNumber(8)
  BooleanSelection get mintingSelection => $_getN(7);
  @$pb.TagNumber(8)
  set mintingSelection(BooleanSelection v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasMintingSelection() => $_has(7);
  @$pb.TagNumber(8)
  void clearMintingSelection() => clearField(8);
  @$pb.TagNumber(8)
  BooleanSelection ensureMintingSelection() => $_ensure(7);

  @$pb.TagNumber(9)
  StringSelection get txIdSelection => $_getN(8);
  @$pb.TagNumber(9)
  set txIdSelection(StringSelection v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasTxIdSelection() => $_has(8);
  @$pb.TagNumber(9)
  void clearTxIdSelection() => clearField(9);
  @$pb.TagNumber(9)
  StringSelection ensureTxIdSelection() => $_ensure(8);

  @$pb.TagNumber(10)
  StringSelection get boxesToRemoveSelection => $_getN(9);
  @$pb.TagNumber(10)
  set boxesToRemoveSelection(StringSelection v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasBoxesToRemoveSelection() => $_has(9);
  @$pb.TagNumber(10)
  void clearBoxesToRemoveSelection() => clearField(10);
  @$pb.TagNumber(10)
  StringSelection ensureBoxesToRemoveSelection() => $_ensure(9);

  @$pb.TagNumber(11)
  NumberRange get feeRange => $_getN(10);
  @$pb.TagNumber(11)
  set feeRange(NumberRange v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasFeeRange() => $_has(10);
  @$pb.TagNumber(11)
  void clearFeeRange() => clearField(11);
  @$pb.TagNumber(11)
  NumberRange ensureFeeRange() => $_ensure(10);

  @$pb.TagNumber(12)
  StringSelection get propositionSelection => $_getN(11);
  @$pb.TagNumber(12)
  set propositionSelection(StringSelection v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasPropositionSelection() => $_has(11);
  @$pb.TagNumber(12)
  void clearPropositionSelection() => clearField(12);
  @$pb.TagNumber(12)
  StringSelection ensurePropositionSelection() => $_ensure(11);

  @$pb.TagNumber(13)
  StringSelection get blockIdSelection => $_getN(12);
  @$pb.TagNumber(13)
  set blockIdSelection(StringSelection v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasBlockIdSelection() => $_has(12);
  @$pb.TagNumber(13)
  void clearBlockIdSelection() => clearField(13);
  @$pb.TagNumber(13)
  StringSelection ensureBlockIdSelection() => $_ensure(12);

  @$pb.TagNumber(14)
  NumberRange get blockHeightRange => $_getN(13);
  @$pb.TagNumber(14)
  set blockHeightRange(NumberRange v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasBlockHeightRange() => $_has(13);
  @$pb.TagNumber(14)
  void clearBlockHeightRange() => clearField(14);
  @$pb.TagNumber(14)
  NumberRange ensureBlockHeightRange() => $_ensure(13);

  @$pb.TagNumber(15)
  TransactionFilter_AndFilter get and => $_getN(14);
  @$pb.TagNumber(15)
  set and(TransactionFilter_AndFilter v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasAnd() => $_has(14);
  @$pb.TagNumber(15)
  void clearAnd() => clearField(15);
  @$pb.TagNumber(15)
  TransactionFilter_AndFilter ensureAnd() => $_ensure(14);

  @$pb.TagNumber(16)
  TransactionFilter_OrFilter get or => $_getN(15);
  @$pb.TagNumber(16)
  set or(TransactionFilter_OrFilter v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasOr() => $_has(15);
  @$pb.TagNumber(16)
  void clearOr() => clearField(16);
  @$pb.TagNumber(16)
  TransactionFilter_OrFilter ensureOr() => $_ensure(15);

  @$pb.TagNumber(17)
  TransactionFilter_NotFilter get not => $_getN(16);
  @$pb.TagNumber(17)
  set not(TransactionFilter_NotFilter v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasNot() => $_has(16);
  @$pb.TagNumber(17)
  void clearNot() => clearField(17);
  @$pb.TagNumber(17)
  TransactionFilter_NotFilter ensureNot() => $_ensure(16);

  @$pb.TagNumber(18)
  TransactionFilter_AllFilter get all => $_getN(17);
  @$pb.TagNumber(18)
  set all(TransactionFilter_AllFilter v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasAll() => $_has(17);
  @$pb.TagNumber(18)
  void clearAll() => clearField(18);
  @$pb.TagNumber(18)
  TransactionFilter_AllFilter ensureAll() => $_ensure(17);
}

class BlockFilter_AndFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockFilter.AndFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..pc<BlockFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filters', $pb.PbFieldType.PM, subBuilder: BlockFilter.create)
    ..hasRequiredFields = false
  ;

  BlockFilter_AndFilter._() : super();
  factory BlockFilter_AndFilter({
    $core.Iterable<BlockFilter>? filters,
  }) {
    final _result = create();
    if (filters != null) {
      _result.filters.addAll(filters);
    }
    return _result;
  }
  factory BlockFilter_AndFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlockFilter_AndFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlockFilter_AndFilter clone() => BlockFilter_AndFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlockFilter_AndFilter copyWith(void Function(BlockFilter_AndFilter) updates) => super.copyWith((message) => updates(message as BlockFilter_AndFilter)) as BlockFilter_AndFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockFilter_AndFilter create() => BlockFilter_AndFilter._();
  BlockFilter_AndFilter createEmptyInstance() => create();
  static $pb.PbList<BlockFilter_AndFilter> createRepeated() => $pb.PbList<BlockFilter_AndFilter>();
  @$core.pragma('dart2js:noInline')
  static BlockFilter_AndFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockFilter_AndFilter>(create);
  static BlockFilter_AndFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BlockFilter> get filters => $_getList(0);
}

class BlockFilter_OrFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockFilter.OrFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..pc<BlockFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filters', $pb.PbFieldType.PM, subBuilder: BlockFilter.create)
    ..hasRequiredFields = false
  ;

  BlockFilter_OrFilter._() : super();
  factory BlockFilter_OrFilter({
    $core.Iterable<BlockFilter>? filters,
  }) {
    final _result = create();
    if (filters != null) {
      _result.filters.addAll(filters);
    }
    return _result;
  }
  factory BlockFilter_OrFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlockFilter_OrFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlockFilter_OrFilter clone() => BlockFilter_OrFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlockFilter_OrFilter copyWith(void Function(BlockFilter_OrFilter) updates) => super.copyWith((message) => updates(message as BlockFilter_OrFilter)) as BlockFilter_OrFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockFilter_OrFilter create() => BlockFilter_OrFilter._();
  BlockFilter_OrFilter createEmptyInstance() => create();
  static $pb.PbList<BlockFilter_OrFilter> createRepeated() => $pb.PbList<BlockFilter_OrFilter>();
  @$core.pragma('dart2js:noInline')
  static BlockFilter_OrFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockFilter_OrFilter>(create);
  static BlockFilter_OrFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BlockFilter> get filters => $_getList(0);
}

class BlockFilter_NotFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockFilter.NotFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..aOM<BlockFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter', subBuilder: BlockFilter.create)
    ..hasRequiredFields = false
  ;

  BlockFilter_NotFilter._() : super();
  factory BlockFilter_NotFilter({
    BlockFilter? filter,
  }) {
    final _result = create();
    if (filter != null) {
      _result.filter = filter;
    }
    return _result;
  }
  factory BlockFilter_NotFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlockFilter_NotFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlockFilter_NotFilter clone() => BlockFilter_NotFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlockFilter_NotFilter copyWith(void Function(BlockFilter_NotFilter) updates) => super.copyWith((message) => updates(message as BlockFilter_NotFilter)) as BlockFilter_NotFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockFilter_NotFilter create() => BlockFilter_NotFilter._();
  BlockFilter_NotFilter createEmptyInstance() => create();
  static $pb.PbList<BlockFilter_NotFilter> createRepeated() => $pb.PbList<BlockFilter_NotFilter>();
  @$core.pragma('dart2js:noInline')
  static BlockFilter_NotFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockFilter_NotFilter>(create);
  static BlockFilter_NotFilter? _defaultInstance;

  @$pb.TagNumber(1)
  BlockFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter(BlockFilter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  BlockFilter ensureFilter() => $_ensure(0);
}

class BlockFilter_AllFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockFilter.AllFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  BlockFilter_AllFilter._() : super();
  factory BlockFilter_AllFilter() => create();
  factory BlockFilter_AllFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlockFilter_AllFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlockFilter_AllFilter clone() => BlockFilter_AllFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlockFilter_AllFilter copyWith(void Function(BlockFilter_AllFilter) updates) => super.copyWith((message) => updates(message as BlockFilter_AllFilter)) as BlockFilter_AllFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockFilter_AllFilter create() => BlockFilter_AllFilter._();
  BlockFilter_AllFilter createEmptyInstance() => create();
  static $pb.PbList<BlockFilter_AllFilter> createRepeated() => $pb.PbList<BlockFilter_AllFilter>();
  @$core.pragma('dart2js:noInline')
  static BlockFilter_AllFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockFilter_AllFilter>(create);
  static BlockFilter_AllFilter? _defaultInstance;
}

enum BlockFilter_FilterType {
  idSelection, 
  parentIdSelection, 
  timestampRange, 
  generatorBoxTokenValueFilter, 
  publicKeySelection, 
  heightRange, 
  heightSelection, 
  difficultyRange, 
  versionSelection, 
  numTransactionRange, 
  and, 
  or, 
  not, 
  all, 
  notSet
}

class BlockFilter extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, BlockFilter_FilterType> _BlockFilter_FilterTypeByTag = {
    1 : BlockFilter_FilterType.idSelection,
    2 : BlockFilter_FilterType.parentIdSelection,
    3 : BlockFilter_FilterType.timestampRange,
    4 : BlockFilter_FilterType.generatorBoxTokenValueFilter,
    5 : BlockFilter_FilterType.publicKeySelection,
    6 : BlockFilter_FilterType.heightRange,
    7 : BlockFilter_FilterType.heightSelection,
    8 : BlockFilter_FilterType.difficultyRange,
    9 : BlockFilter_FilterType.versionSelection,
    10 : BlockFilter_FilterType.numTransactionRange,
    15 : BlockFilter_FilterType.and,
    16 : BlockFilter_FilterType.or,
    17 : BlockFilter_FilterType.not,
    18 : BlockFilter_FilterType.all,
    0 : BlockFilter_FilterType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockFilter', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 16, 17, 18])
    ..aOM<StringSelection>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idSelection', subBuilder: StringSelection.create)
    ..aOM<StringSelection>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parentIdSelection', subBuilder: StringSelection.create)
    ..aOM<NumberRange>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestampRange', subBuilder: NumberRange.create)
    ..aOM<TokenValueFilter>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'generatorBoxTokenValueFilter', subBuilder: TokenValueFilter.create)
    ..aOM<StringSelection>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publicKeySelection', subBuilder: StringSelection.create)
    ..aOM<NumberRange>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'heightRange', subBuilder: NumberRange.create)
    ..aOM<NumberSelection>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'heightSelection', subBuilder: NumberSelection.create)
    ..aOM<NumberRange>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'difficultyRange', subBuilder: NumberRange.create)
    ..aOM<NumberSelection>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'versionSelection', subBuilder: NumberSelection.create)
    ..aOM<NumberRange>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'numTransactionRange', subBuilder: NumberRange.create)
    ..aOM<BlockFilter_AndFilter>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'and', subBuilder: BlockFilter_AndFilter.create)
    ..aOM<BlockFilter_OrFilter>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'or', subBuilder: BlockFilter_OrFilter.create)
    ..aOM<BlockFilter_NotFilter>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'not', subBuilder: BlockFilter_NotFilter.create)
    ..aOM<BlockFilter_AllFilter>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'all', subBuilder: BlockFilter_AllFilter.create)
    ..hasRequiredFields = false
  ;

  BlockFilter._() : super();
  factory BlockFilter({
    StringSelection? idSelection,
    StringSelection? parentIdSelection,
    NumberRange? timestampRange,
    TokenValueFilter? generatorBoxTokenValueFilter,
    StringSelection? publicKeySelection,
    NumberRange? heightRange,
    NumberSelection? heightSelection,
    NumberRange? difficultyRange,
    NumberSelection? versionSelection,
    NumberRange? numTransactionRange,
    BlockFilter_AndFilter? and,
    BlockFilter_OrFilter? or,
    BlockFilter_NotFilter? not,
    BlockFilter_AllFilter? all,
  }) {
    final _result = create();
    if (idSelection != null) {
      _result.idSelection = idSelection;
    }
    if (parentIdSelection != null) {
      _result.parentIdSelection = parentIdSelection;
    }
    if (timestampRange != null) {
      _result.timestampRange = timestampRange;
    }
    if (generatorBoxTokenValueFilter != null) {
      _result.generatorBoxTokenValueFilter = generatorBoxTokenValueFilter;
    }
    if (publicKeySelection != null) {
      _result.publicKeySelection = publicKeySelection;
    }
    if (heightRange != null) {
      _result.heightRange = heightRange;
    }
    if (heightSelection != null) {
      _result.heightSelection = heightSelection;
    }
    if (difficultyRange != null) {
      _result.difficultyRange = difficultyRange;
    }
    if (versionSelection != null) {
      _result.versionSelection = versionSelection;
    }
    if (numTransactionRange != null) {
      _result.numTransactionRange = numTransactionRange;
    }
    if (and != null) {
      _result.and = and;
    }
    if (or != null) {
      _result.or = or;
    }
    if (not != null) {
      _result.not = not;
    }
    if (all != null) {
      _result.all = all;
    }
    return _result;
  }
  factory BlockFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlockFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlockFilter clone() => BlockFilter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlockFilter copyWith(void Function(BlockFilter) updates) => super.copyWith((message) => updates(message as BlockFilter)) as BlockFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockFilter create() => BlockFilter._();
  BlockFilter createEmptyInstance() => create();
  static $pb.PbList<BlockFilter> createRepeated() => $pb.PbList<BlockFilter>();
  @$core.pragma('dart2js:noInline')
  static BlockFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockFilter>(create);
  static BlockFilter? _defaultInstance;

  BlockFilter_FilterType whichFilterType() => _BlockFilter_FilterTypeByTag[$_whichOneof(0)]!;
  void clearFilterType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  StringSelection get idSelection => $_getN(0);
  @$pb.TagNumber(1)
  set idSelection(StringSelection v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIdSelection() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdSelection() => clearField(1);
  @$pb.TagNumber(1)
  StringSelection ensureIdSelection() => $_ensure(0);

  @$pb.TagNumber(2)
  StringSelection get parentIdSelection => $_getN(1);
  @$pb.TagNumber(2)
  set parentIdSelection(StringSelection v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasParentIdSelection() => $_has(1);
  @$pb.TagNumber(2)
  void clearParentIdSelection() => clearField(2);
  @$pb.TagNumber(2)
  StringSelection ensureParentIdSelection() => $_ensure(1);

  @$pb.TagNumber(3)
  NumberRange get timestampRange => $_getN(2);
  @$pb.TagNumber(3)
  set timestampRange(NumberRange v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestampRange() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestampRange() => clearField(3);
  @$pb.TagNumber(3)
  NumberRange ensureTimestampRange() => $_ensure(2);

  @$pb.TagNumber(4)
  TokenValueFilter get generatorBoxTokenValueFilter => $_getN(3);
  @$pb.TagNumber(4)
  set generatorBoxTokenValueFilter(TokenValueFilter v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGeneratorBoxTokenValueFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearGeneratorBoxTokenValueFilter() => clearField(4);
  @$pb.TagNumber(4)
  TokenValueFilter ensureGeneratorBoxTokenValueFilter() => $_ensure(3);

  @$pb.TagNumber(5)
  StringSelection get publicKeySelection => $_getN(4);
  @$pb.TagNumber(5)
  set publicKeySelection(StringSelection v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPublicKeySelection() => $_has(4);
  @$pb.TagNumber(5)
  void clearPublicKeySelection() => clearField(5);
  @$pb.TagNumber(5)
  StringSelection ensurePublicKeySelection() => $_ensure(4);

  @$pb.TagNumber(6)
  NumberRange get heightRange => $_getN(5);
  @$pb.TagNumber(6)
  set heightRange(NumberRange v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasHeightRange() => $_has(5);
  @$pb.TagNumber(6)
  void clearHeightRange() => clearField(6);
  @$pb.TagNumber(6)
  NumberRange ensureHeightRange() => $_ensure(5);

  @$pb.TagNumber(7)
  NumberSelection get heightSelection => $_getN(6);
  @$pb.TagNumber(7)
  set heightSelection(NumberSelection v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasHeightSelection() => $_has(6);
  @$pb.TagNumber(7)
  void clearHeightSelection() => clearField(7);
  @$pb.TagNumber(7)
  NumberSelection ensureHeightSelection() => $_ensure(6);

  @$pb.TagNumber(8)
  NumberRange get difficultyRange => $_getN(7);
  @$pb.TagNumber(8)
  set difficultyRange(NumberRange v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasDifficultyRange() => $_has(7);
  @$pb.TagNumber(8)
  void clearDifficultyRange() => clearField(8);
  @$pb.TagNumber(8)
  NumberRange ensureDifficultyRange() => $_ensure(7);

  @$pb.TagNumber(9)
  NumberSelection get versionSelection => $_getN(8);
  @$pb.TagNumber(9)
  set versionSelection(NumberSelection v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasVersionSelection() => $_has(8);
  @$pb.TagNumber(9)
  void clearVersionSelection() => clearField(9);
  @$pb.TagNumber(9)
  NumberSelection ensureVersionSelection() => $_ensure(8);

  @$pb.TagNumber(10)
  NumberRange get numTransactionRange => $_getN(9);
  @$pb.TagNumber(10)
  set numTransactionRange(NumberRange v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasNumTransactionRange() => $_has(9);
  @$pb.TagNumber(10)
  void clearNumTransactionRange() => clearField(10);
  @$pb.TagNumber(10)
  NumberRange ensureNumTransactionRange() => $_ensure(9);

  @$pb.TagNumber(15)
  BlockFilter_AndFilter get and => $_getN(10);
  @$pb.TagNumber(15)
  set and(BlockFilter_AndFilter v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasAnd() => $_has(10);
  @$pb.TagNumber(15)
  void clearAnd() => clearField(15);
  @$pb.TagNumber(15)
  BlockFilter_AndFilter ensureAnd() => $_ensure(10);

  @$pb.TagNumber(16)
  BlockFilter_OrFilter get or => $_getN(11);
  @$pb.TagNumber(16)
  set or(BlockFilter_OrFilter v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasOr() => $_has(11);
  @$pb.TagNumber(16)
  void clearOr() => clearField(16);
  @$pb.TagNumber(16)
  BlockFilter_OrFilter ensureOr() => $_ensure(11);

  @$pb.TagNumber(17)
  BlockFilter_NotFilter get not => $_getN(12);
  @$pb.TagNumber(17)
  set not(BlockFilter_NotFilter v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasNot() => $_has(12);
  @$pb.TagNumber(17)
  void clearNot() => clearField(17);
  @$pb.TagNumber(17)
  BlockFilter_NotFilter ensureNot() => $_ensure(12);

  @$pb.TagNumber(18)
  BlockFilter_AllFilter get all => $_getN(13);
  @$pb.TagNumber(18)
  set all(BlockFilter_AllFilter v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasAll() => $_has(13);
  @$pb.TagNumber(18)
  void clearAll() => clearField(18);
  @$pb.TagNumber(18)
  BlockFilter_AllFilter ensureAll() => $_ensure(13);
}

