///
//  Generated code. Do not modify.
//  source: blocks_subscription.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'blocks_subscription.pb.dart' as $3;
export 'blocks_subscription.pb.dart';

class BlocksSubscriptionClient extends $grpc.Client {
  static final _$create = $grpc.ClientMethod<$3.CreateBlocksSubscriptionReq,
          $3.BlocksSubscriptionRes>(
      '/co.topl.genus.services.BlocksSubscription/Create',
      ($3.CreateBlocksSubscriptionReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $3.BlocksSubscriptionRes.fromBuffer(value));

  BlocksSubscriptionClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$3.BlocksSubscriptionRes> create(
      $3.CreateBlocksSubscriptionReq request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$create, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class BlocksSubscriptionServiceBase extends $grpc.Service {
  $core.String get $name => 'co.topl.genus.services.BlocksSubscription';

  BlocksSubscriptionServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.CreateBlocksSubscriptionReq,
            $3.BlocksSubscriptionRes>(
        'Create',
        create_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $3.CreateBlocksSubscriptionReq.fromBuffer(value),
        ($3.BlocksSubscriptionRes value) => value.writeToBuffer()));
  }

  $async.Stream<$3.BlocksSubscriptionRes> create_Pre($grpc.ServiceCall call,
      $async.Future<$3.CreateBlocksSubscriptionReq> request) async* {
    yield* create(call, await request);
  }

  $async.Stream<$3.BlocksSubscriptionRes> create(
      $grpc.ServiceCall call, $3.CreateBlocksSubscriptionReq request);
}
