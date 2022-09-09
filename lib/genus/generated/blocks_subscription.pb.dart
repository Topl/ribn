///
//  Generated code. Do not modify.
//  source: blocks_subscription.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'filters.pb.dart' as $4;
import 'types.pb.dart' as $6;

class CreateBlocksSubscriptionReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateBlocksSubscriptionReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'), createEmptyInstance: create)
    ..aOM<$4.BlockFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter', subBuilder: $4.BlockFilter.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmationDepth', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startHeight', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  CreateBlocksSubscriptionReq._() : super();
  factory CreateBlocksSubscriptionReq({
    $4.BlockFilter? filter,
    $core.int? confirmationDepth,
    $fixnum.Int64? startHeight,
  }) {
    final _result = create();
    if (filter != null) {
      _result.filter = filter;
    }
    if (confirmationDepth != null) {
      _result.confirmationDepth = confirmationDepth;
    }
    if (startHeight != null) {
      _result.startHeight = startHeight;
    }
    return _result;
  }
  factory CreateBlocksSubscriptionReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateBlocksSubscriptionReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateBlocksSubscriptionReq clone() => CreateBlocksSubscriptionReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateBlocksSubscriptionReq copyWith(void Function(CreateBlocksSubscriptionReq) updates) => super.copyWith((message) => updates(message as CreateBlocksSubscriptionReq)) as CreateBlocksSubscriptionReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateBlocksSubscriptionReq create() => CreateBlocksSubscriptionReq._();
  CreateBlocksSubscriptionReq createEmptyInstance() => create();
  static $pb.PbList<CreateBlocksSubscriptionReq> createRepeated() => $pb.PbList<CreateBlocksSubscriptionReq>();
  @$core.pragma('dart2js:noInline')
  static CreateBlocksSubscriptionReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateBlocksSubscriptionReq>(create);
  static CreateBlocksSubscriptionReq? _defaultInstance;

  @$pb.TagNumber(1)
  $4.BlockFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter($4.BlockFilter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  $4.BlockFilter ensureFilter() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get confirmationDepth => $_getIZ(1);
  @$pb.TagNumber(2)
  set confirmationDepth($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConfirmationDepth() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfirmationDepth() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get startHeight => $_getI64(2);
  @$pb.TagNumber(3)
  set startHeight($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartHeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartHeight() => clearField(3);
}

enum BlocksSubscriptionRes_Failure_Reason {
  invalidRequest, 
  dataConnectionError, 
  notSet
}

class BlocksSubscriptionRes_Failure extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, BlocksSubscriptionRes_Failure_Reason> _BlocksSubscriptionRes_Failure_ReasonByTag = {
    1 : BlocksSubscriptionRes_Failure_Reason.invalidRequest,
    2 : BlocksSubscriptionRes_Failure_Reason.dataConnectionError,
    0 : BlocksSubscriptionRes_Failure_Reason.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlocksSubscriptionRes.Failure', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invalidRequest')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataConnectionError')
    ..hasRequiredFields = false
  ;

  BlocksSubscriptionRes_Failure._() : super();
  factory BlocksSubscriptionRes_Failure({
    $core.String? invalidRequest,
    $core.String? dataConnectionError,
  }) {
    final _result = create();
    if (invalidRequest != null) {
      _result.invalidRequest = invalidRequest;
    }
    if (dataConnectionError != null) {
      _result.dataConnectionError = dataConnectionError;
    }
    return _result;
  }
  factory BlocksSubscriptionRes_Failure.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlocksSubscriptionRes_Failure.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlocksSubscriptionRes_Failure clone() => BlocksSubscriptionRes_Failure()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlocksSubscriptionRes_Failure copyWith(void Function(BlocksSubscriptionRes_Failure) updates) => super.copyWith((message) => updates(message as BlocksSubscriptionRes_Failure)) as BlocksSubscriptionRes_Failure; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlocksSubscriptionRes_Failure create() => BlocksSubscriptionRes_Failure._();
  BlocksSubscriptionRes_Failure createEmptyInstance() => create();
  static $pb.PbList<BlocksSubscriptionRes_Failure> createRepeated() => $pb.PbList<BlocksSubscriptionRes_Failure>();
  @$core.pragma('dart2js:noInline')
  static BlocksSubscriptionRes_Failure getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlocksSubscriptionRes_Failure>(create);
  static BlocksSubscriptionRes_Failure? _defaultInstance;

  BlocksSubscriptionRes_Failure_Reason whichReason() => _BlocksSubscriptionRes_Failure_ReasonByTag[$_whichOneof(0)]!;
  void clearReason() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get invalidRequest => $_getSZ(0);
  @$pb.TagNumber(1)
  set invalidRequest($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvalidRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvalidRequest() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get dataConnectionError => $_getSZ(1);
  @$pb.TagNumber(2)
  set dataConnectionError($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDataConnectionError() => $_has(1);
  @$pb.TagNumber(2)
  void clearDataConnectionError() => clearField(2);
}

enum BlocksSubscriptionRes_Result {
  success, 
  failure, 
  notSet
}

class BlocksSubscriptionRes extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, BlocksSubscriptionRes_Result> _BlocksSubscriptionRes_ResultByTag = {
    1 : BlocksSubscriptionRes_Result.success,
    2 : BlocksSubscriptionRes_Result.failure,
    0 : BlocksSubscriptionRes_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlocksSubscriptionRes', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<$6.Block>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success', subBuilder: $6.Block.create)
    ..aOM<BlocksSubscriptionRes_Failure>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failure', subBuilder: BlocksSubscriptionRes_Failure.create)
    ..hasRequiredFields = false
  ;

  BlocksSubscriptionRes._() : super();
  factory BlocksSubscriptionRes({
    $6.Block? success,
    BlocksSubscriptionRes_Failure? failure,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (failure != null) {
      _result.failure = failure;
    }
    return _result;
  }
  factory BlocksSubscriptionRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlocksSubscriptionRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlocksSubscriptionRes clone() => BlocksSubscriptionRes()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlocksSubscriptionRes copyWith(void Function(BlocksSubscriptionRes) updates) => super.copyWith((message) => updates(message as BlocksSubscriptionRes)) as BlocksSubscriptionRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlocksSubscriptionRes create() => BlocksSubscriptionRes._();
  BlocksSubscriptionRes createEmptyInstance() => create();
  static $pb.PbList<BlocksSubscriptionRes> createRepeated() => $pb.PbList<BlocksSubscriptionRes>();
  @$core.pragma('dart2js:noInline')
  static BlocksSubscriptionRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlocksSubscriptionRes>(create);
  static BlocksSubscriptionRes? _defaultInstance;

  BlocksSubscriptionRes_Result whichResult() => _BlocksSubscriptionRes_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $6.Block get success => $_getN(0);
  @$pb.TagNumber(1)
  set success($6.Block v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
  @$pb.TagNumber(1)
  $6.Block ensureSuccess() => $_ensure(0);

  @$pb.TagNumber(2)
  BlocksSubscriptionRes_Failure get failure => $_getN(1);
  @$pb.TagNumber(2)
  set failure(BlocksSubscriptionRes_Failure v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasFailure() => $_has(1);
  @$pb.TagNumber(2)
  void clearFailure() => clearField(2);
  @$pb.TagNumber(2)
  BlocksSubscriptionRes_Failure ensureFailure() => $_ensure(1);
}

