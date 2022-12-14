///
//  Generated code. Do not modify.
//  source: transactions_subscription.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use createTxsSubscriptionReqDescriptor instead')
const CreateTxsSubscriptionReq$json = const {
  '1': 'CreateTxsSubscriptionReq',
  '2': const [
    const {
      '1': 'filter',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.TransactionFilter',
      '10': 'filter'
    },
    const {'1': 'start_height', '3': 2, '4': 1, '5': 4, '10': 'startHeight'},
    const {
      '1': 'confirmation_depth',
      '3': 3,
      '4': 1,
      '5': 13,
      '10': 'confirmationDepth'
    },
  ],
};

/// Descriptor for `CreateTxsSubscriptionReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTxsSubscriptionReqDescriptor =
    $convert.base64Decode(
        'ChhDcmVhdGVUeHNTdWJzY3JpcHRpb25SZXESOAoGZmlsdGVyGAEgASgLMiAuY28udG9wbC5nZW51cy5UcmFuc2FjdGlvbkZpbHRlclIGZmlsdGVyEiEKDHN0YXJ0X2hlaWdodBgCIAEoBFILc3RhcnRIZWlnaHQSLQoSY29uZmlybWF0aW9uX2RlcHRoGAMgASgNUhFjb25maXJtYXRpb25EZXB0aA==');
@$core.Deprecated('Use txsSubscriptionResDescriptor instead')
const TxsSubscriptionRes$json = const {
  '1': 'TxsSubscriptionRes',
  '2': const [
    const {
      '1': 'success',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.Transaction',
      '9': 0,
      '10': 'success'
    },
    const {
      '1': 'failure',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.TxsSubscriptionRes.Failure',
      '9': 0,
      '10': 'failure'
    },
  ],
  '3': const [TxsSubscriptionRes_Failure$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use txsSubscriptionResDescriptor instead')
const TxsSubscriptionRes_Failure$json = const {
  '1': 'Failure',
  '2': const [
    const {
      '1': 'invalid_request',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'invalidRequest'
    },
    const {
      '1': 'data_connection_error',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'dataConnectionError'
    },
  ],
  '8': const [
    const {'1': 'reason'},
  ],
};

/// Descriptor for `TxsSubscriptionRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List txsSubscriptionResDescriptor = $convert.base64Decode(
    'ChJUeHNTdWJzY3JpcHRpb25SZXMSNgoHc3VjY2VzcxgBIAEoCzIaLmNvLnRvcGwuZ2VudXMuVHJhbnNhY3Rpb25IAFIHc3VjY2VzcxJOCgdmYWlsdXJlGAIgASgLMjIuY28udG9wbC5nZW51cy5zZXJ2aWNlcy5UeHNTdWJzY3JpcHRpb25SZXMuRmFpbHVyZUgAUgdmYWlsdXJlGnQKB0ZhaWx1cmUSKQoPaW52YWxpZF9yZXF1ZXN0GAEgASgJSABSDmludmFsaWRSZXF1ZXN0EjQKFWRhdGFfY29ubmVjdGlvbl9lcnJvchgCIAEoCUgAUhNkYXRhQ29ubmVjdGlvbkVycm9yQggKBnJlYXNvbkIICgZyZXN1bHQ=');
