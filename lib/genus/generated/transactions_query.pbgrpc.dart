///
//  Generated code. Do not modify.
//  source: transactions_query.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// Dart imports:
import 'dart:async' as $async;
import 'dart:core' as $core;

// Package imports:
import 'package:grpc/service_api.dart' as $grpc;

// Project imports:
import 'transactions_query.pb.dart' as $0;

export 'transactions_query.pb.dart';

class TransactionsQueryClient extends $grpc.Client {
  static final _$query = $grpc.ClientMethod<$0.QueryTxsReq, $0.QueryTxsRes>(
    '/co.topl.genus.services.TransactionsQuery/Query',
    ($0.QueryTxsReq value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.QueryTxsRes.fromBuffer(value),
  );
  static final _$queryStreamed =
      $grpc.ClientMethod<$0.TxsQueryStreamReq, $0.TxsQueryStreamRes>(
    '/co.topl.genus.services.TransactionsQuery/QueryStreamed',
    ($0.TxsQueryStreamReq value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.TxsQueryStreamRes.fromBuffer(value),
  );

  TransactionsQueryClient(
    $grpc.ClientChannel channel, {
    $grpc.CallOptions? options,
    $core.Iterable<$grpc.ClientInterceptor>? interceptors,
  }) : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.QueryTxsRes> query(
    $0.QueryTxsReq request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$query, request, options: options);
  }

  $grpc.ResponseStream<$0.TxsQueryStreamRes> queryStreamed(
    $0.TxsQueryStreamReq request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
      _$queryStreamed,
      $async.Stream.fromIterable([request]),
      options: options,
    );
  }
}

abstract class TransactionsQueryServiceBase extends $grpc.Service {
  $core.String get $name => 'co.topl.genus.services.TransactionsQuery';

  TransactionsQueryServiceBase() {
    $addMethod(
      $grpc.ServiceMethod<$0.QueryTxsReq, $0.QueryTxsRes>(
        'Query',
        query_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.QueryTxsReq.fromBuffer(value),
        ($0.QueryTxsRes value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.TxsQueryStreamReq, $0.TxsQueryStreamRes>(
        'QueryStreamed',
        queryStreamed_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.TxsQueryStreamReq.fromBuffer(value),
        ($0.TxsQueryStreamRes value) => value.writeToBuffer(),
      ),
    );
  }

  $async.Future<$0.QueryTxsRes> query_Pre(
    $grpc.ServiceCall call,
    $async.Future<$0.QueryTxsReq> request,
  ) async {
    return query(call, await request);
  }

  $async.Stream<$0.TxsQueryStreamRes> queryStreamed_Pre(
    $grpc.ServiceCall call,
    $async.Future<$0.TxsQueryStreamReq> request,
  ) async* {
    yield* queryStreamed(call, await request);
  }

  $async.Future<$0.QueryTxsRes> query(
    $grpc.ServiceCall call,
    $0.QueryTxsReq request,
  );
  $async.Stream<$0.TxsQueryStreamRes> queryStreamed(
    $grpc.ServiceCall call,
    $0.TxsQueryStreamReq request,
  );
}
