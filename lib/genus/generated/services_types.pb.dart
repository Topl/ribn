///
//  Generated code. Do not modify.
//  source: services_types.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// Dart imports:
import 'dart:core' as $core;

// Package imports:
import 'package:protobuf/protobuf.dart' as $pb;

class Paging extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
    const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Paging',
    package: const $pb.PackageName(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'co.topl.genus.services',
    ),
    createEmptyInstance: create,
  )
    ..a<$core.int>(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageNumber',
      $pb.PbFieldType.OU3,
    )
    ..a<$core.int>(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize',
      $pb.PbFieldType.OU3,
    )
    ..hasRequiredFields = false;

  Paging._() : super();
  factory Paging({
    $core.int? pageNumber,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (pageNumber != null) {
      _result.pageNumber = pageNumber;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory Paging.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Paging.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
    'Will be removed in next major version',
  )
  Paging clone() => Paging()..mergeFromMessage(this);
  @$core.Deprecated(
    'Using this can add significant overhead to your binary. '
    'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
    'Will be removed in next major version',
  )
  Paging copyWith(void Function(Paging) updates) =>
      super.copyWith((message) => updates(message as Paging)) as Paging; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Paging create() => Paging._();
  Paging createEmptyInstance() => create();
  static $pb.PbList<Paging> createRepeated() => $pb.PbList<Paging>();
  @$core.pragma('dart2js:noInline')
  static Paging getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Paging>(create);
  static Paging? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageNumber($core.int v) {
    $_setUnsignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPageNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) {
    $_setUnsignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);
}
