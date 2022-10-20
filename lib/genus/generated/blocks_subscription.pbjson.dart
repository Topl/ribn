///
//  Generated code. Do not modify.
//  source: blocks_subscription.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use createBlocksSubscriptionReqDescriptor instead')
const CreateBlocksSubscriptionReq$json = const {
  '1': 'CreateBlocksSubscriptionReq',
  '2': const [
    const {'1': 'filter', '3': 1, '4': 1, '5': 11, '6': '.co.topl.genus.BlockFilter', '10': 'filter'},
    const {'1': 'confirmation_depth', '3': 2, '4': 1, '5': 13, '10': 'confirmationDepth'},
    const {'1': 'start_height', '3': 3, '4': 1, '5': 4, '10': 'startHeight'},
  ],
};

/// Descriptor for `CreateBlocksSubscriptionReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createBlocksSubscriptionReqDescriptor = $convert.base64Decode('ChtDcmVhdGVCbG9ja3NTdWJzY3JpcHRpb25SZXESMgoGZmlsdGVyGAEgASgLMhouY28udG9wbC5nZW51cy5CbG9ja0ZpbHRlclIGZmlsdGVyEi0KEmNvbmZpcm1hdGlvbl9kZXB0aBgCIAEoDVIRY29uZmlybWF0aW9uRGVwdGgSIQoMc3RhcnRfaGVpZ2h0GAMgASgEUgtzdGFydEhlaWdodA==');
@$core.Deprecated('Use blocksSubscriptionResDescriptor instead')
const BlocksSubscriptionRes$json = const {
  '1': 'BlocksSubscriptionRes',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 11, '6': '.co.topl.genus.Block', '9': 0, '10': 'success'},
    const {'1': 'failure', '3': 2, '4': 1, '5': 11, '6': '.co.topl.genus.services.BlocksSubscriptionRes.Failure', '9': 0, '10': 'failure'},
  ],
  '3': const [BlocksSubscriptionRes_Failure$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use blocksSubscriptionResDescriptor instead')
const BlocksSubscriptionRes_Failure$json = const {
  '1': 'Failure',
  '2': const [
    const {'1': 'invalid_request', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'invalidRequest'},
    const {'1': 'data_connection_error', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'dataConnectionError'},
  ],
  '8': const [
    const {'1': 'reason'},
  ],
};

/// Descriptor for `BlocksSubscriptionRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blocksSubscriptionResDescriptor = $convert.base64Decode('ChVCbG9ja3NTdWJzY3JpcHRpb25SZXMSMAoHc3VjY2VzcxgBIAEoCzIULmNvLnRvcGwuZ2VudXMuQmxvY2tIAFIHc3VjY2VzcxJRCgdmYWlsdXJlGAIgASgLMjUuY28udG9wbC5nZW51cy5zZXJ2aWNlcy5CbG9ja3NTdWJzY3JpcHRpb25SZXMuRmFpbHVyZUgAUgdmYWlsdXJlGnQKB0ZhaWx1cmUSKQoPaW52YWxpZF9yZXF1ZXN0GAEgASgJSABSDmludmFsaWRSZXF1ZXN0EjQKFWRhdGFfY29ubmVjdGlvbl9lcnJvchgCIAEoCUgAUhNkYXRhQ29ubmVjdGlvbkVycm9yQggKBnJlYXNvbkIICgZyZXN1bHQ=');
