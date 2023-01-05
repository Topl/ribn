///
//  Generated code. Do not modify.
//  source: blocks_query.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'blocks_query.pb.dart' as $1;
export 'blocks_query.pb.dart';

class BlocksQueryClient extends $grpc.Client {
  static final _$query =
      $grpc.ClientMethod<$1.QueryBlocksReq, $1.QueryBlocksRes>(
    '/co.topl.genus.services.BlocksQuery/Query',
    ($1.QueryBlocksReq value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $1.QueryBlocksRes.fromBuffer(value),
  );
  static final _$queryStream =
      $grpc.ClientMethod<$1.BlocksQueryStreamReq, $1.BlocksQueryStreamRes>(
    '/co.topl.genus.services.BlocksQuery/QueryStream',
    ($1.BlocksQueryStreamReq value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $1.BlocksQueryStreamRes.fromBuffer(value),
  );

  BlocksQueryClient(
    $grpc.ClientChannel channel, {
    $grpc.CallOptions? options,
    $core.Iterable<$grpc.ClientInterceptor>? interceptors,
  }) : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.QueryBlocksRes> query(
    $1.QueryBlocksReq request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$query, request, options: options);
  }

  $grpc.ResponseStream<$1.BlocksQueryStreamRes> queryStream(
    $1.BlocksQueryStreamReq request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
      _$queryStream,
      $async.Stream.fromIterable([request]),
      options: options,
    );
  }
}

abstract class BlocksQueryServiceBase extends $grpc.Service {
  $core.String get $name => 'co.topl.genus.services.BlocksQuery';

  BlocksQueryServiceBase() {
    $addMethod(
      $grpc.ServiceMethod<$1.QueryBlocksReq, $1.QueryBlocksRes>(
        'Query',
        query_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.QueryBlocksReq.fromBuffer(value),
        ($1.QueryBlocksRes value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$1.BlocksQueryStreamReq, $1.BlocksQueryStreamRes>(
        'QueryStream',
        queryStream_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $1.BlocksQueryStreamReq.fromBuffer(value),
        ($1.BlocksQueryStreamRes value) => value.writeToBuffer(),
      ),
    );
  }

  $async.Future<$1.QueryBlocksRes> query_Pre(
    $grpc.ServiceCall call,
    $async.Future<$1.QueryBlocksReq> request,
  ) async {
    return query(call, await request);
  }

  $async.Stream<$1.BlocksQueryStreamRes> queryStream_Pre(
    $grpc.ServiceCall call,
    $async.Future<$1.BlocksQueryStreamReq> request,
  ) async* {
    yield* queryStream(call, await request);
  }

  $async.Future<$1.QueryBlocksRes> query(
    $grpc.ServiceCall call,
    $1.QueryBlocksReq request,
  );
  $async.Stream<$1.BlocksQueryStreamRes> queryStream(
    $grpc.ServiceCall call,
    $1.BlocksQueryStreamReq request,
  );
}
