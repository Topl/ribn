///
//  Generated code. Do not modify.
//  source: transactions_subscription.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// Dart imports:
import 'dart:core' as $core;

// Package imports:
import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

// Project imports:
import 'filters.pb.dart' as $4;
import 'types.pb.dart' as $6;

class CreateTxsSubscriptionReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
    const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateTxsSubscriptionReq',
    package: const $pb.PackageName(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services',
    ),
    createEmptyInstance: create,
  )
    ..aOM<$4.TransactionFilter>(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter',
      subBuilder: $4.TransactionFilter.create,
    )
    ..a<$fixnum.Int64>(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startHeight',
      $pb.PbFieldType.OU6,
      defaultOrMaker: $fixnum.Int64.ZERO,
    )
    ..a<$core.int>(
      3,
      const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmationDepth',
      $pb.PbFieldType.OU3,
    )
    ..hasRequiredFields = false;

  CreateTxsSubscriptionReq._() : super();
  factory CreateTxsSubscriptionReq({
    $4.TransactionFilter? filter,
    $fixnum.Int64? startHeight,
    $core.int? confirmationDepth,
  }) {
    final _result = create();
    if (filter != null) {
      _result.filter = filter;
    }
    if (startHeight != null) {
      _result.startHeight = startHeight;
    }
    if (confirmationDepth != null) {
      _result.confirmationDepth = confirmationDepth;
    }
    return _result;
  }
  factory CreateTxsSubscriptionReq.fromBuffer(
    $core.List<$core.int> i, [
    $pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY,
  ]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateTxsSubscriptionReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  CreateTxsSubscriptionReq clone() => CreateTxsSubscriptionReq()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  CreateTxsSubscriptionReq copyWith(void Function(CreateTxsSubscriptionReq) updates) =>
      super.copyWith((message) => updates(message as CreateTxsSubscriptionReq))
          as CreateTxsSubscriptionReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateTxsSubscriptionReq create() => CreateTxsSubscriptionReq._();
  CreateTxsSubscriptionReq createEmptyInstance() => create();
  static $pb.PbList<CreateTxsSubscriptionReq> createRepeated() => $pb.PbList<CreateTxsSubscriptionReq>();
  @$core.pragma('dart2js:noInline')
  static CreateTxsSubscriptionReq getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTxsSubscriptionReq>(create);
  static CreateTxsSubscriptionReq? _defaultInstance;

  @$pb.TagNumber(1)
  $4.TransactionFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter($4.TransactionFilter v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  $4.TransactionFilter ensureFilter() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get startHeight => $_getI64(1);
  @$pb.TagNumber(2)
  set startHeight($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasStartHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartHeight() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get confirmationDepth => $_getIZ(2);
  @$pb.TagNumber(3)
  set confirmationDepth($core.int v) {
    $_setUnsignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasConfirmationDepth() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfirmationDepth() => clearField(3);
}

enum TxsSubscriptionRes_Failure_Reason { invalidRequest, dataConnectionError, notSet }

class TxsSubscriptionRes_Failure extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, TxsSubscriptionRes_Failure_Reason> _TxsSubscriptionRes_Failure_ReasonByTag = {
    1: TxsSubscriptionRes_Failure_Reason.invalidRequest,
    2: TxsSubscriptionRes_Failure_Reason.dataConnectionError,
    0: TxsSubscriptionRes_Failure_Reason.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
    const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TxsSubscriptionRes.Failure',
    package: const $pb.PackageName(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services',
    ),
    createEmptyInstance: create,
  )
    ..oo(0, [1, 2])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invalidRequest')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataConnectionError')
    ..hasRequiredFields = false;

  TxsSubscriptionRes_Failure._() : super();
  factory TxsSubscriptionRes_Failure({
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
  factory TxsSubscriptionRes_Failure.fromBuffer(
    $core.List<$core.int> i, [
    $pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY,
  ]) =>
      create()..mergeFromBuffer(i, r);
  factory TxsSubscriptionRes_Failure.fromJson(
    $core.String i, [
    $pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY,
  ]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  TxsSubscriptionRes_Failure clone() => TxsSubscriptionRes_Failure()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  TxsSubscriptionRes_Failure copyWith(void Function(TxsSubscriptionRes_Failure) updates) =>
      super.copyWith((message) => updates(message as TxsSubscriptionRes_Failure))
          as TxsSubscriptionRes_Failure; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TxsSubscriptionRes_Failure create() => TxsSubscriptionRes_Failure._();
  TxsSubscriptionRes_Failure createEmptyInstance() => create();
  static $pb.PbList<TxsSubscriptionRes_Failure> createRepeated() => $pb.PbList<TxsSubscriptionRes_Failure>();
  @$core.pragma('dart2js:noInline')
  static TxsSubscriptionRes_Failure getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TxsSubscriptionRes_Failure>(create);
  static TxsSubscriptionRes_Failure? _defaultInstance;

  TxsSubscriptionRes_Failure_Reason whichReason() => _TxsSubscriptionRes_Failure_ReasonByTag[$_whichOneof(0)]!;
  void clearReason() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get invalidRequest => $_getSZ(0);
  @$pb.TagNumber(1)
  set invalidRequest($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasInvalidRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvalidRequest() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get dataConnectionError => $_getSZ(1);
  @$pb.TagNumber(2)
  set dataConnectionError($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDataConnectionError() => $_has(1);
  @$pb.TagNumber(2)
  void clearDataConnectionError() => clearField(2);
}

enum TxsSubscriptionRes_Result { success, failure, notSet }

class TxsSubscriptionRes extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, TxsSubscriptionRes_Result> _TxsSubscriptionRes_ResultByTag = {
    1: TxsSubscriptionRes_Result.success,
    2: TxsSubscriptionRes_Result.failure,
    0: TxsSubscriptionRes_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
    const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TxsSubscriptionRes',
    package: const $pb.PackageName(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services',
    ),
    createEmptyInstance: create,
  )
    ..oo(0, [1, 2])
    ..aOM<$6.Transaction>(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success',
      subBuilder: $6.Transaction.create,
    )
    ..aOM<TxsSubscriptionRes_Failure>(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failure',
      subBuilder: TxsSubscriptionRes_Failure.create,
    )
    ..hasRequiredFields = false;

  TxsSubscriptionRes._() : super();
  factory TxsSubscriptionRes({
    $6.Transaction? success,
    TxsSubscriptionRes_Failure? failure,
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
  factory TxsSubscriptionRes.fromBuffer(
    $core.List<$core.int> i, [
    $pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY,
  ]) =>
      create()..mergeFromBuffer(i, r);
  factory TxsSubscriptionRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  TxsSubscriptionRes clone() => TxsSubscriptionRes()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  TxsSubscriptionRes copyWith(void Function(TxsSubscriptionRes) updates) =>
      super.copyWith((message) => updates(message as TxsSubscriptionRes))
          as TxsSubscriptionRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TxsSubscriptionRes create() => TxsSubscriptionRes._();
  TxsSubscriptionRes createEmptyInstance() => create();
  static $pb.PbList<TxsSubscriptionRes> createRepeated() => $pb.PbList<TxsSubscriptionRes>();
  @$core.pragma('dart2js:noInline')
  static TxsSubscriptionRes getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TxsSubscriptionRes>(create);
  static TxsSubscriptionRes? _defaultInstance;

  TxsSubscriptionRes_Result whichResult() => _TxsSubscriptionRes_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $6.Transaction get success => $_getN(0);
  @$pb.TagNumber(1)
  set success($6.Transaction v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
  @$pb.TagNumber(1)
  $6.Transaction ensureSuccess() => $_ensure(0);

  @$pb.TagNumber(2)
  TxsSubscriptionRes_Failure get failure => $_getN(1);
  @$pb.TagNumber(2)
  set failure(TxsSubscriptionRes_Failure v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFailure() => $_has(1);
  @$pb.TagNumber(2)
  void clearFailure() => clearField(2);
  @$pb.TagNumber(2)
  TxsSubscriptionRes_Failure ensureFailure() => $_ensure(1);
}
