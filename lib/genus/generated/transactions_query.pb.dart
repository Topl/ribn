///
//  Generated code. Do not modify.
//  source: transactions_query.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'filters.pb.dart' as $4;
import 'services_types.pb.dart' as $5;
import 'types.pb.dart' as $6;

class TransactionSorting_Height extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionSorting.Height',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'descending')
    ..hasRequiredFields = false;

  TransactionSorting_Height._() : super();
  factory TransactionSorting_Height({
    $core.bool? descending,
  }) {
    final _result = create();
    if (descending != null) {
      _result.descending = descending;
    }
    return _result;
  }
  factory TransactionSorting_Height.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TransactionSorting_Height.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  TransactionSorting_Height clone() => TransactionSorting_Height()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  TransactionSorting_Height copyWith(void Function(TransactionSorting_Height) updates) =>
      super.copyWith((message) => updates(message as TransactionSorting_Height))
          as TransactionSorting_Height; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionSorting_Height create() => TransactionSorting_Height._();
  TransactionSorting_Height createEmptyInstance() => create();
  static $pb.PbList<TransactionSorting_Height> createRepeated() => $pb.PbList<TransactionSorting_Height>();
  @$core.pragma('dart2js:noInline')
  static TransactionSorting_Height getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionSorting_Height>(create);
  static TransactionSorting_Height? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get descending => $_getBF(0);
  @$pb.TagNumber(1)
  set descending($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDescending() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescending() => clearField(1);
}

class TransactionSorting_Fee extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionSorting.Fee',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'descending')
    ..hasRequiredFields = false;

  TransactionSorting_Fee._() : super();
  factory TransactionSorting_Fee({
    $core.bool? descending,
  }) {
    final _result = create();
    if (descending != null) {
      _result.descending = descending;
    }
    return _result;
  }
  factory TransactionSorting_Fee.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TransactionSorting_Fee.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  TransactionSorting_Fee clone() => TransactionSorting_Fee()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  TransactionSorting_Fee copyWith(void Function(TransactionSorting_Fee) updates) =>
      super.copyWith((message) => updates(message as TransactionSorting_Fee))
          as TransactionSorting_Fee; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionSorting_Fee create() => TransactionSorting_Fee._();
  TransactionSorting_Fee createEmptyInstance() => create();
  static $pb.PbList<TransactionSorting_Fee> createRepeated() => $pb.PbList<TransactionSorting_Fee>();
  @$core.pragma('dart2js:noInline')
  static TransactionSorting_Fee getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionSorting_Fee>(create);
  static TransactionSorting_Fee? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get descending => $_getBF(0);
  @$pb.TagNumber(1)
  set descending($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDescending() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescending() => clearField(1);
}

class TransactionSorting_Timestamp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionSorting.Timestamp',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'descending')
    ..hasRequiredFields = false;

  TransactionSorting_Timestamp._() : super();
  factory TransactionSorting_Timestamp({
    $core.bool? descending,
  }) {
    final _result = create();
    if (descending != null) {
      _result.descending = descending;
    }
    return _result;
  }
  factory TransactionSorting_Timestamp.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TransactionSorting_Timestamp.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  TransactionSorting_Timestamp clone() => TransactionSorting_Timestamp()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  TransactionSorting_Timestamp copyWith(void Function(TransactionSorting_Timestamp) updates) =>
      super.copyWith((message) => updates(message as TransactionSorting_Timestamp))
          as TransactionSorting_Timestamp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionSorting_Timestamp create() => TransactionSorting_Timestamp._();
  TransactionSorting_Timestamp createEmptyInstance() => create();
  static $pb.PbList<TransactionSorting_Timestamp> createRepeated() => $pb.PbList<TransactionSorting_Timestamp>();
  @$core.pragma('dart2js:noInline')
  static TransactionSorting_Timestamp getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionSorting_Timestamp>(create);
  static TransactionSorting_Timestamp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get descending => $_getBF(0);
  @$pb.TagNumber(1)
  set descending($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDescending() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescending() => clearField(1);
}

enum TransactionSorting_SortBy { height, fee, timestamp, notSet }

class TransactionSorting extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, TransactionSorting_SortBy> _TransactionSorting_SortByByTag = {
    1: TransactionSorting_SortBy.height,
    2: TransactionSorting_SortBy.fee,
    3: TransactionSorting_SortBy.timestamp,
    0: TransactionSorting_SortBy.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransactionSorting',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<TransactionSorting_Height>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height',
        subBuilder: TransactionSorting_Height.create)
    ..aOM<TransactionSorting_Fee>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee',
        subBuilder: TransactionSorting_Fee.create)
    ..aOM<TransactionSorting_Timestamp>(
        3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp',
        subBuilder: TransactionSorting_Timestamp.create)
    ..hasRequiredFields = false;

  TransactionSorting._() : super();
  factory TransactionSorting({
    TransactionSorting_Height? height,
    TransactionSorting_Fee? fee,
    TransactionSorting_Timestamp? timestamp,
  }) {
    final _result = create();
    if (height != null) {
      _result.height = height;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory TransactionSorting.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TransactionSorting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  TransactionSorting clone() => TransactionSorting()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  TransactionSorting copyWith(void Function(TransactionSorting) updates) =>
      super.copyWith((message) => updates(message as TransactionSorting))
          as TransactionSorting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransactionSorting create() => TransactionSorting._();
  TransactionSorting createEmptyInstance() => create();
  static $pb.PbList<TransactionSorting> createRepeated() => $pb.PbList<TransactionSorting>();
  @$core.pragma('dart2js:noInline')
  static TransactionSorting getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionSorting>(create);
  static TransactionSorting? _defaultInstance;

  TransactionSorting_SortBy whichSortBy() => _TransactionSorting_SortByByTag[$_whichOneof(0)]!;
  void clearSortBy() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  TransactionSorting_Height get height => $_getN(0);
  @$pb.TagNumber(1)
  set height(TransactionSorting_Height v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasHeight() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeight() => clearField(1);
  @$pb.TagNumber(1)
  TransactionSorting_Height ensureHeight() => $_ensure(0);

  @$pb.TagNumber(2)
  TransactionSorting_Fee get fee => $_getN(1);
  @$pb.TagNumber(2)
  set fee(TransactionSorting_Fee v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFee() => $_has(1);
  @$pb.TagNumber(2)
  void clearFee() => clearField(2);
  @$pb.TagNumber(2)
  TransactionSorting_Fee ensureFee() => $_ensure(1);

  @$pb.TagNumber(3)
  TransactionSorting_Timestamp get timestamp => $_getN(2);
  @$pb.TagNumber(3)
  set timestamp(TransactionSorting_Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);
  @$pb.TagNumber(3)
  TransactionSorting_Timestamp ensureTimestamp() => $_ensure(2);
}

class QueryTxsReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QueryTxsReq',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..aOM<$4.TransactionFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter',
        subBuilder: $4.TransactionFilter.create)
    ..aOM<TransactionSorting>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sorting',
        subBuilder: TransactionSorting.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmationDepth',
        $pb.PbFieldType.OU3)
    ..aOM<$5.Paging>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagingOptions',
        subBuilder: $5.Paging.create)
    ..hasRequiredFields = false;

  QueryTxsReq._() : super();
  factory QueryTxsReq({
    $4.TransactionFilter? filter,
    TransactionSorting? sorting,
    $core.int? confirmationDepth,
    $5.Paging? pagingOptions,
  }) {
    final _result = create();
    if (filter != null) {
      _result.filter = filter;
    }
    if (sorting != null) {
      _result.sorting = sorting;
    }
    if (confirmationDepth != null) {
      _result.confirmationDepth = confirmationDepth;
    }
    if (pagingOptions != null) {
      _result.pagingOptions = pagingOptions;
    }
    return _result;
  }
  factory QueryTxsReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryTxsReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  QueryTxsReq clone() => QueryTxsReq()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  QueryTxsReq copyWith(void Function(QueryTxsReq) updates) =>
      super.copyWith((message) => updates(message as QueryTxsReq)) as QueryTxsReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QueryTxsReq create() => QueryTxsReq._();
  QueryTxsReq createEmptyInstance() => create();
  static $pb.PbList<QueryTxsReq> createRepeated() => $pb.PbList<QueryTxsReq>();
  @$core.pragma('dart2js:noInline')
  static QueryTxsReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryTxsReq>(create);
  static QueryTxsReq? _defaultInstance;

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
  TransactionSorting get sorting => $_getN(1);
  @$pb.TagNumber(2)
  set sorting(TransactionSorting v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSorting() => $_has(1);
  @$pb.TagNumber(2)
  void clearSorting() => clearField(2);
  @$pb.TagNumber(2)
  TransactionSorting ensureSorting() => $_ensure(1);

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

  @$pb.TagNumber(4)
  $5.Paging get pagingOptions => $_getN(3);
  @$pb.TagNumber(4)
  set pagingOptions($5.Paging v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPagingOptions() => $_has(3);
  @$pb.TagNumber(4)
  void clearPagingOptions() => clearField(4);
  @$pb.TagNumber(4)
  $5.Paging ensurePagingOptions() => $_ensure(3);
}

class QueryTxsRes_Success extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QueryTxsRes.Success',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..pc<$6.Transaction>(
        1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: $6.Transaction.create)
    ..hasRequiredFields = false;

  QueryTxsRes_Success._() : super();
  factory QueryTxsRes_Success({
    $core.Iterable<$6.Transaction>? transactions,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    return _result;
  }
  factory QueryTxsRes_Success.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryTxsRes_Success.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  QueryTxsRes_Success clone() => QueryTxsRes_Success()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  QueryTxsRes_Success copyWith(void Function(QueryTxsRes_Success) updates) =>
      super.copyWith((message) => updates(message as QueryTxsRes_Success))
          as QueryTxsRes_Success; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QueryTxsRes_Success create() => QueryTxsRes_Success._();
  QueryTxsRes_Success createEmptyInstance() => create();
  static $pb.PbList<QueryTxsRes_Success> createRepeated() => $pb.PbList<QueryTxsRes_Success>();
  @$core.pragma('dart2js:noInline')
  static QueryTxsRes_Success getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryTxsRes_Success>(create);
  static QueryTxsRes_Success? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$6.Transaction> get transactions => $_getList(0);
}

enum QueryTxsRes_Failure_Reason { dataStoreConnectionError, queryTimeout, invalidQuery, notSet }

class QueryTxsRes_Failure extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, QueryTxsRes_Failure_Reason> _QueryTxsRes_Failure_ReasonByTag = {
    1: QueryTxsRes_Failure_Reason.dataStoreConnectionError,
    2: QueryTxsRes_Failure_Reason.queryTimeout,
    3: QueryTxsRes_Failure_Reason.invalidQuery,
    0: QueryTxsRes_Failure_Reason.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QueryTxsRes.Failure',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataStoreConnectionError')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'queryTimeout')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invalidQuery')
    ..hasRequiredFields = false;

  QueryTxsRes_Failure._() : super();
  factory QueryTxsRes_Failure({
    $core.String? dataStoreConnectionError,
    $core.String? queryTimeout,
    $core.String? invalidQuery,
  }) {
    final _result = create();
    if (dataStoreConnectionError != null) {
      _result.dataStoreConnectionError = dataStoreConnectionError;
    }
    if (queryTimeout != null) {
      _result.queryTimeout = queryTimeout;
    }
    if (invalidQuery != null) {
      _result.invalidQuery = invalidQuery;
    }
    return _result;
  }
  factory QueryTxsRes_Failure.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryTxsRes_Failure.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  QueryTxsRes_Failure clone() => QueryTxsRes_Failure()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  QueryTxsRes_Failure copyWith(void Function(QueryTxsRes_Failure) updates) =>
      super.copyWith((message) => updates(message as QueryTxsRes_Failure))
          as QueryTxsRes_Failure; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QueryTxsRes_Failure create() => QueryTxsRes_Failure._();
  QueryTxsRes_Failure createEmptyInstance() => create();
  static $pb.PbList<QueryTxsRes_Failure> createRepeated() => $pb.PbList<QueryTxsRes_Failure>();
  @$core.pragma('dart2js:noInline')
  static QueryTxsRes_Failure getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryTxsRes_Failure>(create);
  static QueryTxsRes_Failure? _defaultInstance;

  QueryTxsRes_Failure_Reason whichReason() => _QueryTxsRes_Failure_ReasonByTag[$_whichOneof(0)]!;
  void clearReason() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get dataStoreConnectionError => $_getSZ(0);
  @$pb.TagNumber(1)
  set dataStoreConnectionError($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDataStoreConnectionError() => $_has(0);
  @$pb.TagNumber(1)
  void clearDataStoreConnectionError() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get queryTimeout => $_getSZ(1);
  @$pb.TagNumber(2)
  set queryTimeout($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasQueryTimeout() => $_has(1);
  @$pb.TagNumber(2)
  void clearQueryTimeout() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get invalidQuery => $_getSZ(2);
  @$pb.TagNumber(3)
  set invalidQuery($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasInvalidQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvalidQuery() => clearField(3);
}

enum QueryTxsRes_Result { success, failure, notSet }

class QueryTxsRes extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, QueryTxsRes_Result> _QueryTxsRes_ResultByTag = {
    1: QueryTxsRes_Result.success,
    2: QueryTxsRes_Result.failure,
    0: QueryTxsRes_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QueryTxsRes',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<QueryTxsRes_Success>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success',
        subBuilder: QueryTxsRes_Success.create)
    ..aOM<QueryTxsRes_Failure>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failure',
        subBuilder: QueryTxsRes_Failure.create)
    ..hasRequiredFields = false;

  QueryTxsRes._() : super();
  factory QueryTxsRes({
    QueryTxsRes_Success? success,
    QueryTxsRes_Failure? failure,
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
  factory QueryTxsRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryTxsRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  QueryTxsRes clone() => QueryTxsRes()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  QueryTxsRes copyWith(void Function(QueryTxsRes) updates) =>
      super.copyWith((message) => updates(message as QueryTxsRes)) as QueryTxsRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QueryTxsRes create() => QueryTxsRes._();
  QueryTxsRes createEmptyInstance() => create();
  static $pb.PbList<QueryTxsRes> createRepeated() => $pb.PbList<QueryTxsRes>();
  @$core.pragma('dart2js:noInline')
  static QueryTxsRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryTxsRes>(create);
  static QueryTxsRes? _defaultInstance;

  QueryTxsRes_Result whichResult() => _QueryTxsRes_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  QueryTxsRes_Success get success => $_getN(0);
  @$pb.TagNumber(1)
  set success(QueryTxsRes_Success v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
  @$pb.TagNumber(1)
  QueryTxsRes_Success ensureSuccess() => $_ensure(0);

  @$pb.TagNumber(2)
  QueryTxsRes_Failure get failure => $_getN(1);
  @$pb.TagNumber(2)
  set failure(QueryTxsRes_Failure v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFailure() => $_has(1);
  @$pb.TagNumber(2)
  void clearFailure() => clearField(2);
  @$pb.TagNumber(2)
  QueryTxsRes_Failure ensureFailure() => $_ensure(1);
}

class TxsQueryStreamReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TxsQueryStreamReq',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..aOM<$4.TransactionFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter',
        subBuilder: $4.TransactionFilter.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmationDepth',
        $pb.PbFieldType.OU3)
    ..aOM<TransactionSorting>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sorting',
        subBuilder: TransactionSorting.create)
    ..hasRequiredFields = false;

  TxsQueryStreamReq._() : super();
  factory TxsQueryStreamReq({
    $4.TransactionFilter? filter,
    $core.int? confirmationDepth,
    TransactionSorting? sorting,
  }) {
    final _result = create();
    if (filter != null) {
      _result.filter = filter;
    }
    if (confirmationDepth != null) {
      _result.confirmationDepth = confirmationDepth;
    }
    if (sorting != null) {
      _result.sorting = sorting;
    }
    return _result;
  }
  factory TxsQueryStreamReq.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TxsQueryStreamReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  TxsQueryStreamReq clone() => TxsQueryStreamReq()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  TxsQueryStreamReq copyWith(void Function(TxsQueryStreamReq) updates) =>
      super.copyWith((message) => updates(message as TxsQueryStreamReq))
          as TxsQueryStreamReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TxsQueryStreamReq create() => TxsQueryStreamReq._();
  TxsQueryStreamReq createEmptyInstance() => create();
  static $pb.PbList<TxsQueryStreamReq> createRepeated() => $pb.PbList<TxsQueryStreamReq>();
  @$core.pragma('dart2js:noInline')
  static TxsQueryStreamReq getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TxsQueryStreamReq>(create);
  static TxsQueryStreamReq? _defaultInstance;

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
  $core.int get confirmationDepth => $_getIZ(1);
  @$pb.TagNumber(2)
  set confirmationDepth($core.int v) {
    $_setUnsignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasConfirmationDepth() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfirmationDepth() => clearField(2);

  @$pb.TagNumber(4)
  TransactionSorting get sorting => $_getN(2);
  @$pb.TagNumber(4)
  set sorting(TransactionSorting v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSorting() => $_has(2);
  @$pb.TagNumber(4)
  void clearSorting() => clearField(4);
  @$pb.TagNumber(4)
  TransactionSorting ensureSorting() => $_ensure(2);
}

enum TxsQueryStreamRes_Failure_Reason { dataStoreConnectionError, invalidQuery, notSet }

class TxsQueryStreamRes_Failure extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, TxsQueryStreamRes_Failure_Reason> _TxsQueryStreamRes_Failure_ReasonByTag = {
    1: TxsQueryStreamRes_Failure_Reason.dataStoreConnectionError,
    2: TxsQueryStreamRes_Failure_Reason.invalidQuery,
    0: TxsQueryStreamRes_Failure_Reason.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TxsQueryStreamRes.Failure',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataStoreConnectionError')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invalidQuery')
    ..hasRequiredFields = false;

  TxsQueryStreamRes_Failure._() : super();
  factory TxsQueryStreamRes_Failure({
    $core.String? dataStoreConnectionError,
    $core.String? invalidQuery,
  }) {
    final _result = create();
    if (dataStoreConnectionError != null) {
      _result.dataStoreConnectionError = dataStoreConnectionError;
    }
    if (invalidQuery != null) {
      _result.invalidQuery = invalidQuery;
    }
    return _result;
  }
  factory TxsQueryStreamRes_Failure.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TxsQueryStreamRes_Failure.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  TxsQueryStreamRes_Failure clone() => TxsQueryStreamRes_Failure()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  TxsQueryStreamRes_Failure copyWith(void Function(TxsQueryStreamRes_Failure) updates) =>
      super.copyWith((message) => updates(message as TxsQueryStreamRes_Failure))
          as TxsQueryStreamRes_Failure; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TxsQueryStreamRes_Failure create() => TxsQueryStreamRes_Failure._();
  TxsQueryStreamRes_Failure createEmptyInstance() => create();
  static $pb.PbList<TxsQueryStreamRes_Failure> createRepeated() => $pb.PbList<TxsQueryStreamRes_Failure>();
  @$core.pragma('dart2js:noInline')
  static TxsQueryStreamRes_Failure getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TxsQueryStreamRes_Failure>(create);
  static TxsQueryStreamRes_Failure? _defaultInstance;

  TxsQueryStreamRes_Failure_Reason whichReason() => _TxsQueryStreamRes_Failure_ReasonByTag[$_whichOneof(0)]!;
  void clearReason() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get dataStoreConnectionError => $_getSZ(0);
  @$pb.TagNumber(1)
  set dataStoreConnectionError($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDataStoreConnectionError() => $_has(0);
  @$pb.TagNumber(1)
  void clearDataStoreConnectionError() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get invalidQuery => $_getSZ(1);
  @$pb.TagNumber(2)
  set invalidQuery($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasInvalidQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvalidQuery() => clearField(2);
}

enum TxsQueryStreamRes_Result { tx, failure, notSet }

class TxsQueryStreamRes extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, TxsQueryStreamRes_Result> _TxsQueryStreamRes_ResultByTag = {
    1: TxsQueryStreamRes_Result.tx,
    2: TxsQueryStreamRes_Result.failure,
    0: TxsQueryStreamRes_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TxsQueryStreamRes',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<$6.Transaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tx',
        subBuilder: $6.Transaction.create)
    ..aOM<TxsQueryStreamRes_Failure>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failure',
        subBuilder: TxsQueryStreamRes_Failure.create)
    ..hasRequiredFields = false;

  TxsQueryStreamRes._() : super();
  factory TxsQueryStreamRes({
    $6.Transaction? tx,
    TxsQueryStreamRes_Failure? failure,
  }) {
    final _result = create();
    if (tx != null) {
      _result.tx = tx;
    }
    if (failure != null) {
      _result.failure = failure;
    }
    return _result;
  }
  factory TxsQueryStreamRes.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TxsQueryStreamRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  TxsQueryStreamRes clone() => TxsQueryStreamRes()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  TxsQueryStreamRes copyWith(void Function(TxsQueryStreamRes) updates) =>
      super.copyWith((message) => updates(message as TxsQueryStreamRes))
          as TxsQueryStreamRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TxsQueryStreamRes create() => TxsQueryStreamRes._();
  TxsQueryStreamRes createEmptyInstance() => create();
  static $pb.PbList<TxsQueryStreamRes> createRepeated() => $pb.PbList<TxsQueryStreamRes>();
  @$core.pragma('dart2js:noInline')
  static TxsQueryStreamRes getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TxsQueryStreamRes>(create);
  static TxsQueryStreamRes? _defaultInstance;

  TxsQueryStreamRes_Result whichResult() => _TxsQueryStreamRes_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $6.Transaction get tx => $_getN(0);
  @$pb.TagNumber(1)
  set tx($6.Transaction v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTx() => $_has(0);
  @$pb.TagNumber(1)
  void clearTx() => clearField(1);
  @$pb.TagNumber(1)
  $6.Transaction ensureTx() => $_ensure(0);

  @$pb.TagNumber(2)
  TxsQueryStreamRes_Failure get failure => $_getN(1);
  @$pb.TagNumber(2)
  set failure(TxsQueryStreamRes_Failure v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFailure() => $_has(1);
  @$pb.TagNumber(2)
  void clearFailure() => clearField(2);
  @$pb.TagNumber(2)
  TxsQueryStreamRes_Failure ensureFailure() => $_ensure(1);
}
