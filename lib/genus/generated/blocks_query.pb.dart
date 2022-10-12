///
//  Generated code. Do not modify.
//  source: blocks_query.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'filters.pb.dart' as $4;
import 'services_types.pb.dart' as $5;
import 'types.pb.dart' as $6;

class BlockSorting_Height extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockSorting.Height',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'descending')
    ..hasRequiredFields = false;

  BlockSorting_Height._() : super();
  factory BlockSorting_Height({
    $core.bool? descending,
  }) {
    final _result = create();
    if (descending != null) {
      _result.descending = descending;
    }
    return _result;
  }
  factory BlockSorting_Height.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BlockSorting_Height.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  BlockSorting_Height clone() => BlockSorting_Height()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  BlockSorting_Height copyWith(void Function(BlockSorting_Height) updates) =>
      super.copyWith((message) => updates(message as BlockSorting_Height))
          as BlockSorting_Height; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockSorting_Height create() => BlockSorting_Height._();
  BlockSorting_Height createEmptyInstance() => create();
  static $pb.PbList<BlockSorting_Height> createRepeated() => $pb.PbList<BlockSorting_Height>();
  @$core.pragma('dart2js:noInline')
  static BlockSorting_Height getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockSorting_Height>(create);
  static BlockSorting_Height? _defaultInstance;

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

class BlockSorting_Timestamp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockSorting.Timestamp',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'descending')
    ..hasRequiredFields = false;

  BlockSorting_Timestamp._() : super();
  factory BlockSorting_Timestamp({
    $core.bool? descending,
  }) {
    final _result = create();
    if (descending != null) {
      _result.descending = descending;
    }
    return _result;
  }
  factory BlockSorting_Timestamp.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BlockSorting_Timestamp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  BlockSorting_Timestamp clone() => BlockSorting_Timestamp()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  BlockSorting_Timestamp copyWith(void Function(BlockSorting_Timestamp) updates) =>
      super.copyWith((message) => updates(message as BlockSorting_Timestamp))
          as BlockSorting_Timestamp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockSorting_Timestamp create() => BlockSorting_Timestamp._();
  BlockSorting_Timestamp createEmptyInstance() => create();
  static $pb.PbList<BlockSorting_Timestamp> createRepeated() => $pb.PbList<BlockSorting_Timestamp>();
  @$core.pragma('dart2js:noInline')
  static BlockSorting_Timestamp getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockSorting_Timestamp>(create);
  static BlockSorting_Timestamp? _defaultInstance;

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

class BlockSorting_Difficulty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockSorting.Difficulty',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'descending')
    ..hasRequiredFields = false;

  BlockSorting_Difficulty._() : super();
  factory BlockSorting_Difficulty({
    $core.bool? descending,
  }) {
    final _result = create();
    if (descending != null) {
      _result.descending = descending;
    }
    return _result;
  }
  factory BlockSorting_Difficulty.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BlockSorting_Difficulty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  BlockSorting_Difficulty clone() => BlockSorting_Difficulty()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  BlockSorting_Difficulty copyWith(void Function(BlockSorting_Difficulty) updates) =>
      super.copyWith((message) => updates(message as BlockSorting_Difficulty))
          as BlockSorting_Difficulty; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockSorting_Difficulty create() => BlockSorting_Difficulty._();
  BlockSorting_Difficulty createEmptyInstance() => create();
  static $pb.PbList<BlockSorting_Difficulty> createRepeated() => $pb.PbList<BlockSorting_Difficulty>();
  @$core.pragma('dart2js:noInline')
  static BlockSorting_Difficulty getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockSorting_Difficulty>(create);
  static BlockSorting_Difficulty? _defaultInstance;

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

class BlockSorting_NumberOfTransactions extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockSorting.NumberOfTransactions',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'descending')
    ..hasRequiredFields = false;

  BlockSorting_NumberOfTransactions._() : super();
  factory BlockSorting_NumberOfTransactions({
    $core.bool? descending,
  }) {
    final _result = create();
    if (descending != null) {
      _result.descending = descending;
    }
    return _result;
  }
  factory BlockSorting_NumberOfTransactions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BlockSorting_NumberOfTransactions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  BlockSorting_NumberOfTransactions clone() => BlockSorting_NumberOfTransactions()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  BlockSorting_NumberOfTransactions copyWith(void Function(BlockSorting_NumberOfTransactions) updates) =>
      super.copyWith((message) => updates(message as BlockSorting_NumberOfTransactions))
          as BlockSorting_NumberOfTransactions; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockSorting_NumberOfTransactions create() => BlockSorting_NumberOfTransactions._();
  BlockSorting_NumberOfTransactions createEmptyInstance() => create();
  static $pb.PbList<BlockSorting_NumberOfTransactions> createRepeated() =>
      $pb.PbList<BlockSorting_NumberOfTransactions>();
  @$core.pragma('dart2js:noInline')
  static BlockSorting_NumberOfTransactions getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockSorting_NumberOfTransactions>(create);
  static BlockSorting_NumberOfTransactions? _defaultInstance;

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

enum BlockSorting_SortBy { height, timestamp, difficulty, numberOfTransactions, notSet }

class BlockSorting extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, BlockSorting_SortBy> _BlockSorting_SortByByTag = {
    1: BlockSorting_SortBy.height,
    2: BlockSorting_SortBy.timestamp,
    3: BlockSorting_SortBy.difficulty,
    4: BlockSorting_SortBy.numberOfTransactions,
    0: BlockSorting_SortBy.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockSorting',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<BlockSorting_Height>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height',
        subBuilder: BlockSorting_Height.create)
    ..aOM<BlockSorting_Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp',
        subBuilder: BlockSorting_Timestamp.create)
    ..aOM<BlockSorting_Difficulty>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'difficulty',
        subBuilder: BlockSorting_Difficulty.create)
    ..aOM<BlockSorting_NumberOfTransactions>(
        4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'numberOfTransactions',
        subBuilder: BlockSorting_NumberOfTransactions.create)
    ..hasRequiredFields = false;

  BlockSorting._() : super();
  factory BlockSorting({
    BlockSorting_Height? height,
    BlockSorting_Timestamp? timestamp,
    BlockSorting_Difficulty? difficulty,
    BlockSorting_NumberOfTransactions? numberOfTransactions,
  }) {
    final _result = create();
    if (height != null) {
      _result.height = height;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (difficulty != null) {
      _result.difficulty = difficulty;
    }
    if (numberOfTransactions != null) {
      _result.numberOfTransactions = numberOfTransactions;
    }
    return _result;
  }
  factory BlockSorting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BlockSorting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  BlockSorting clone() => BlockSorting()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  BlockSorting copyWith(void Function(BlockSorting) updates) =>
      super.copyWith((message) => updates(message as BlockSorting)) as BlockSorting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockSorting create() => BlockSorting._();
  BlockSorting createEmptyInstance() => create();
  static $pb.PbList<BlockSorting> createRepeated() => $pb.PbList<BlockSorting>();
  @$core.pragma('dart2js:noInline')
  static BlockSorting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockSorting>(create);
  static BlockSorting? _defaultInstance;

  BlockSorting_SortBy whichSortBy() => _BlockSorting_SortByByTag[$_whichOneof(0)]!;
  void clearSortBy() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  BlockSorting_Height get height => $_getN(0);
  @$pb.TagNumber(1)
  set height(BlockSorting_Height v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasHeight() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeight() => clearField(1);
  @$pb.TagNumber(1)
  BlockSorting_Height ensureHeight() => $_ensure(0);

  @$pb.TagNumber(2)
  BlockSorting_Timestamp get timestamp => $_getN(1);
  @$pb.TagNumber(2)
  set timestamp(BlockSorting_Timestamp v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => clearField(2);
  @$pb.TagNumber(2)
  BlockSorting_Timestamp ensureTimestamp() => $_ensure(1);

  @$pb.TagNumber(3)
  BlockSorting_Difficulty get difficulty => $_getN(2);
  @$pb.TagNumber(3)
  set difficulty(BlockSorting_Difficulty v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDifficulty() => $_has(2);
  @$pb.TagNumber(3)
  void clearDifficulty() => clearField(3);
  @$pb.TagNumber(3)
  BlockSorting_Difficulty ensureDifficulty() => $_ensure(2);

  @$pb.TagNumber(4)
  BlockSorting_NumberOfTransactions get numberOfTransactions => $_getN(3);
  @$pb.TagNumber(4)
  set numberOfTransactions(BlockSorting_NumberOfTransactions v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasNumberOfTransactions() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumberOfTransactions() => clearField(4);
  @$pb.TagNumber(4)
  BlockSorting_NumberOfTransactions ensureNumberOfTransactions() => $_ensure(3);
}

class QueryBlocksReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QueryBlocksReq',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..aOM<$4.BlockFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter',
        subBuilder: $4.BlockFilter.create)
    ..aOM<BlockSorting>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sorting',
        subBuilder: BlockSorting.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmationDepth',
        $pb.PbFieldType.OU3)
    ..aOM<$5.Paging>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagingOptions',
        subBuilder: $5.Paging.create)
    ..hasRequiredFields = false;

  QueryBlocksReq._() : super();
  factory QueryBlocksReq({
    $4.BlockFilter? filter,
    BlockSorting? sorting,
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
  factory QueryBlocksReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryBlocksReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  QueryBlocksReq clone() => QueryBlocksReq()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  QueryBlocksReq copyWith(void Function(QueryBlocksReq) updates) =>
      super.copyWith((message) => updates(message as QueryBlocksReq))
          as QueryBlocksReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QueryBlocksReq create() => QueryBlocksReq._();
  QueryBlocksReq createEmptyInstance() => create();
  static $pb.PbList<QueryBlocksReq> createRepeated() => $pb.PbList<QueryBlocksReq>();
  @$core.pragma('dart2js:noInline')
  static QueryBlocksReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryBlocksReq>(create);
  static QueryBlocksReq? _defaultInstance;

  @$pb.TagNumber(1)
  $4.BlockFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter($4.BlockFilter v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  $4.BlockFilter ensureFilter() => $_ensure(0);

  @$pb.TagNumber(2)
  BlockSorting get sorting => $_getN(1);
  @$pb.TagNumber(2)
  set sorting(BlockSorting v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSorting() => $_has(1);
  @$pb.TagNumber(2)
  void clearSorting() => clearField(2);
  @$pb.TagNumber(2)
  BlockSorting ensureSorting() => $_ensure(1);

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

class QueryBlocksRes_Success extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QueryBlocksRes.Success',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..pc<$6.Block>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blocks', $pb.PbFieldType.PM,
        subBuilder: $6.Block.create)
    ..hasRequiredFields = false;

  QueryBlocksRes_Success._() : super();
  factory QueryBlocksRes_Success({
    $core.Iterable<$6.Block>? blocks,
  }) {
    final _result = create();
    if (blocks != null) {
      _result.blocks.addAll(blocks);
    }
    return _result;
  }
  factory QueryBlocksRes_Success.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryBlocksRes_Success.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  QueryBlocksRes_Success clone() => QueryBlocksRes_Success()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  QueryBlocksRes_Success copyWith(void Function(QueryBlocksRes_Success) updates) =>
      super.copyWith((message) => updates(message as QueryBlocksRes_Success))
          as QueryBlocksRes_Success; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QueryBlocksRes_Success create() => QueryBlocksRes_Success._();
  QueryBlocksRes_Success createEmptyInstance() => create();
  static $pb.PbList<QueryBlocksRes_Success> createRepeated() => $pb.PbList<QueryBlocksRes_Success>();
  @$core.pragma('dart2js:noInline')
  static QueryBlocksRes_Success getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryBlocksRes_Success>(create);
  static QueryBlocksRes_Success? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$6.Block> get blocks => $_getList(0);
}

enum QueryBlocksRes_Failure_Reason { dataStoreConnectionError, queryTimeout, invalidQuery, notSet }

class QueryBlocksRes_Failure extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, QueryBlocksRes_Failure_Reason> _QueryBlocksRes_Failure_ReasonByTag = {
    1: QueryBlocksRes_Failure_Reason.dataStoreConnectionError,
    2: QueryBlocksRes_Failure_Reason.queryTimeout,
    3: QueryBlocksRes_Failure_Reason.invalidQuery,
    0: QueryBlocksRes_Failure_Reason.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QueryBlocksRes.Failure',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataStoreConnectionError')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'queryTimeout')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invalidQuery')
    ..hasRequiredFields = false;

  QueryBlocksRes_Failure._() : super();
  factory QueryBlocksRes_Failure({
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
  factory QueryBlocksRes_Failure.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryBlocksRes_Failure.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  QueryBlocksRes_Failure clone() => QueryBlocksRes_Failure()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  QueryBlocksRes_Failure copyWith(void Function(QueryBlocksRes_Failure) updates) =>
      super.copyWith((message) => updates(message as QueryBlocksRes_Failure))
          as QueryBlocksRes_Failure; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QueryBlocksRes_Failure create() => QueryBlocksRes_Failure._();
  QueryBlocksRes_Failure createEmptyInstance() => create();
  static $pb.PbList<QueryBlocksRes_Failure> createRepeated() => $pb.PbList<QueryBlocksRes_Failure>();
  @$core.pragma('dart2js:noInline')
  static QueryBlocksRes_Failure getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryBlocksRes_Failure>(create);
  static QueryBlocksRes_Failure? _defaultInstance;

  QueryBlocksRes_Failure_Reason whichReason() => _QueryBlocksRes_Failure_ReasonByTag[$_whichOneof(0)]!;
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

enum QueryBlocksRes_Result { success, failure, notSet }

class QueryBlocksRes extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, QueryBlocksRes_Result> _QueryBlocksRes_ResultByTag = {
    1: QueryBlocksRes_Result.success,
    2: QueryBlocksRes_Result.failure,
    0: QueryBlocksRes_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QueryBlocksRes',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<QueryBlocksRes_Success>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success',
        subBuilder: QueryBlocksRes_Success.create)
    ..aOM<QueryBlocksRes_Failure>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failure',
        subBuilder: QueryBlocksRes_Failure.create)
    ..hasRequiredFields = false;

  QueryBlocksRes._() : super();
  factory QueryBlocksRes({
    QueryBlocksRes_Success? success,
    QueryBlocksRes_Failure? failure,
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
  factory QueryBlocksRes.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryBlocksRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  QueryBlocksRes clone() => QueryBlocksRes()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  QueryBlocksRes copyWith(void Function(QueryBlocksRes) updates) =>
      super.copyWith((message) => updates(message as QueryBlocksRes))
          as QueryBlocksRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QueryBlocksRes create() => QueryBlocksRes._();
  QueryBlocksRes createEmptyInstance() => create();
  static $pb.PbList<QueryBlocksRes> createRepeated() => $pb.PbList<QueryBlocksRes>();
  @$core.pragma('dart2js:noInline')
  static QueryBlocksRes getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryBlocksRes>(create);
  static QueryBlocksRes? _defaultInstance;

  QueryBlocksRes_Result whichResult() => _QueryBlocksRes_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  QueryBlocksRes_Success get success => $_getN(0);
  @$pb.TagNumber(1)
  set success(QueryBlocksRes_Success v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
  @$pb.TagNumber(1)
  QueryBlocksRes_Success ensureSuccess() => $_ensure(0);

  @$pb.TagNumber(2)
  QueryBlocksRes_Failure get failure => $_getN(1);
  @$pb.TagNumber(2)
  set failure(QueryBlocksRes_Failure v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFailure() => $_has(1);
  @$pb.TagNumber(2)
  void clearFailure() => clearField(2);
  @$pb.TagNumber(2)
  QueryBlocksRes_Failure ensureFailure() => $_ensure(1);
}

class BlocksQueryStreamReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlocksQueryStreamReq',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..aOM<$4.BlockFilter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filter',
        subBuilder: $4.BlockFilter.create)
    ..aOM<BlockSorting>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sorting',
        subBuilder: BlockSorting.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmationDepth',
        $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  BlocksQueryStreamReq._() : super();
  factory BlocksQueryStreamReq({
    $4.BlockFilter? filter,
    BlockSorting? sorting,
    $core.int? confirmationDepth,
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
    return _result;
  }
  factory BlocksQueryStreamReq.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BlocksQueryStreamReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  BlocksQueryStreamReq clone() => BlocksQueryStreamReq()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  BlocksQueryStreamReq copyWith(void Function(BlocksQueryStreamReq) updates) =>
      super.copyWith((message) => updates(message as BlocksQueryStreamReq))
          as BlocksQueryStreamReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlocksQueryStreamReq create() => BlocksQueryStreamReq._();
  BlocksQueryStreamReq createEmptyInstance() => create();
  static $pb.PbList<BlocksQueryStreamReq> createRepeated() => $pb.PbList<BlocksQueryStreamReq>();
  @$core.pragma('dart2js:noInline')
  static BlocksQueryStreamReq getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlocksQueryStreamReq>(create);
  static BlocksQueryStreamReq? _defaultInstance;

  @$pb.TagNumber(1)
  $4.BlockFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter($4.BlockFilter v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => clearField(1);
  @$pb.TagNumber(1)
  $4.BlockFilter ensureFilter() => $_ensure(0);

  @$pb.TagNumber(2)
  BlockSorting get sorting => $_getN(1);
  @$pb.TagNumber(2)
  set sorting(BlockSorting v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSorting() => $_has(1);
  @$pb.TagNumber(2)
  void clearSorting() => clearField(2);
  @$pb.TagNumber(2)
  BlockSorting ensureSorting() => $_ensure(1);

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

enum BlocksQueryStreamRes_Failure_Reason { dataStoreConnectionError, invalidQuery, notSet }

class BlocksQueryStreamRes_Failure extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, BlocksQueryStreamRes_Failure_Reason> _BlocksQueryStreamRes_Failure_ReasonByTag = {
    1: BlocksQueryStreamRes_Failure_Reason.dataStoreConnectionError,
    2: BlocksQueryStreamRes_Failure_Reason.invalidQuery,
    0: BlocksQueryStreamRes_Failure_Reason.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlocksQueryStreamRes.Failure',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataStoreConnectionError')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invalidQuery')
    ..hasRequiredFields = false;

  BlocksQueryStreamRes_Failure._() : super();
  factory BlocksQueryStreamRes_Failure({
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
  factory BlocksQueryStreamRes_Failure.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BlocksQueryStreamRes_Failure.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  BlocksQueryStreamRes_Failure clone() => BlocksQueryStreamRes_Failure()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  BlocksQueryStreamRes_Failure copyWith(void Function(BlocksQueryStreamRes_Failure) updates) =>
      super.copyWith((message) => updates(message as BlocksQueryStreamRes_Failure))
          as BlocksQueryStreamRes_Failure; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlocksQueryStreamRes_Failure create() => BlocksQueryStreamRes_Failure._();
  BlocksQueryStreamRes_Failure createEmptyInstance() => create();
  static $pb.PbList<BlocksQueryStreamRes_Failure> createRepeated() => $pb.PbList<BlocksQueryStreamRes_Failure>();
  @$core.pragma('dart2js:noInline')
  static BlocksQueryStreamRes_Failure getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlocksQueryStreamRes_Failure>(create);
  static BlocksQueryStreamRes_Failure? _defaultInstance;

  BlocksQueryStreamRes_Failure_Reason whichReason() => _BlocksQueryStreamRes_Failure_ReasonByTag[$_whichOneof(0)]!;
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

enum BlocksQueryStreamRes_Result { block, failure, notSet }

class BlocksQueryStreamRes extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, BlocksQueryStreamRes_Result> _BlocksQueryStreamRes_ResultByTag = {
    1: BlocksQueryStreamRes_Result.block,
    2: BlocksQueryStreamRes_Result.failure,
    0: BlocksQueryStreamRes_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlocksQueryStreamRes',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<$6.Block>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'block',
        subBuilder: $6.Block.create)
    ..aOM<BlocksQueryStreamRes_Failure>(
        2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failure',
        subBuilder: BlocksQueryStreamRes_Failure.create)
    ..hasRequiredFields = false;

  BlocksQueryStreamRes._() : super();
  factory BlocksQueryStreamRes({
    $6.Block? block,
    BlocksQueryStreamRes_Failure? failure,
  }) {
    final _result = create();
    if (block != null) {
      _result.block = block;
    }
    if (failure != null) {
      _result.failure = failure;
    }
    return _result;
  }
  factory BlocksQueryStreamRes.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BlocksQueryStreamRes.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  BlocksQueryStreamRes clone() => BlocksQueryStreamRes()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  BlocksQueryStreamRes copyWith(void Function(BlocksQueryStreamRes) updates) =>
      super.copyWith((message) => updates(message as BlocksQueryStreamRes))
          as BlocksQueryStreamRes; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlocksQueryStreamRes create() => BlocksQueryStreamRes._();
  BlocksQueryStreamRes createEmptyInstance() => create();
  static $pb.PbList<BlocksQueryStreamRes> createRepeated() => $pb.PbList<BlocksQueryStreamRes>();
  @$core.pragma('dart2js:noInline')
  static BlocksQueryStreamRes getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlocksQueryStreamRes>(create);
  static BlocksQueryStreamRes? _defaultInstance;

  BlocksQueryStreamRes_Result whichResult() => _BlocksQueryStreamRes_ResultByTag[$_whichOneof(0)]!;
  void clearResult() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $6.Block get block => $_getN(0);
  @$pb.TagNumber(1)
  set block($6.Block v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBlock() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlock() => clearField(1);
  @$pb.TagNumber(1)
  $6.Block ensureBlock() => $_ensure(0);

  @$pb.TagNumber(2)
  BlocksQueryStreamRes_Failure get failure => $_getN(1);
  @$pb.TagNumber(2)
  set failure(BlocksQueryStreamRes_Failure v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFailure() => $_has(1);
  @$pb.TagNumber(2)
  void clearFailure() => clearField(2);
  @$pb.TagNumber(2)
  BlocksQueryStreamRes_Failure ensureFailure() => $_ensure(1);
}
