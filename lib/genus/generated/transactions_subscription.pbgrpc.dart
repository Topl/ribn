///
//  Generated code. Do not modify.
//  source: transactions_subscription.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transactions_subscription.pb.dart' as $2;
export 'transactions_subscription.pb.dart';

class TransactionsSubscriptionClient extends $grpc.Client {
  static final _$create =
      $grpc.ClientMethod<$2.CreateTxsSubscriptionReq, $2.TxsSubscriptionRes>(
          '/co.topl.genus.services.TransactionsSubscription/Create',
          ($2.CreateTxsSubscriptionReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.TxsSubscriptionRes.fromBuffer(value));

  TransactionsSubscriptionClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$2.TxsSubscriptionRes> create(
      $2.CreateTxsSubscriptionReq request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$create, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class TransactionsSubscriptionServiceBase extends $grpc.Service {
  $core.String get $name => 'co.topl.genus.services.TransactionsSubscription';

  TransactionsSubscriptionServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$2.CreateTxsSubscriptionReq, $2.TxsSubscriptionRes>(
            'Create',
            create_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $2.CreateTxsSubscriptionReq.fromBuffer(value),
            ($2.TxsSubscriptionRes value) => value.writeToBuffer()));
  }

  $async.Stream<$2.TxsSubscriptionRes> create_Pre($grpc.ServiceCall call,
      $async.Future<$2.CreateTxsSubscriptionReq> request) async* {
    yield* create(call, await request);
  }

  $async.Stream<$2.TxsSubscriptionRes> create(
      $grpc.ServiceCall call, $2.CreateTxsSubscriptionReq request);
}
