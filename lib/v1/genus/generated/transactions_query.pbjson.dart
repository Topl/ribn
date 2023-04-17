///
//  Generated code. Do not modify.
//  source: transactions_query.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// Dart imports:
import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use transactionSortingDescriptor instead')
const TransactionSorting$json = const {
  '1': 'TransactionSorting',
  '2': const [
    const {
      '1': 'height',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.TransactionSorting.Height',
      '9': 0,
      '10': 'height'
    },
    const {
      '1': 'fee',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.TransactionSorting.Fee',
      '9': 0,
      '10': 'fee'
    },
    const {
      '1': 'timestamp',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.TransactionSorting.Timestamp',
      '9': 0,
      '10': 'timestamp'
    },
  ],
  '3': const [TransactionSorting_Height$json, TransactionSorting_Fee$json, TransactionSorting_Timestamp$json],
  '8': const [
    const {'1': 'sort_by'},
  ],
};

@$core.Deprecated('Use transactionSortingDescriptor instead')
const TransactionSorting_Height$json = const {
  '1': 'Height',
  '2': const [
    const {'1': 'descending', '3': 1, '4': 1, '5': 8, '10': 'descending'},
  ],
};

@$core.Deprecated('Use transactionSortingDescriptor instead')
const TransactionSorting_Fee$json = const {
  '1': 'Fee',
  '2': const [
    const {'1': 'descending', '3': 1, '4': 1, '5': 8, '10': 'descending'},
  ],
};

@$core.Deprecated('Use transactionSortingDescriptor instead')
const TransactionSorting_Timestamp$json = const {
  '1': 'Timestamp',
  '2': const [
    const {'1': 'descending', '3': 1, '4': 1, '5': 8, '10': 'descending'},
  ],
};

/// Descriptor for `TransactionSorting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionSortingDescriptor = $convert.base64Decode(
    'ChJUcmFuc2FjdGlvblNvcnRpbmcSSwoGaGVpZ2h0GAEgASgLMjEuY28udG9wbC5nZW51cy5zZXJ2aWNlcy5UcmFuc2FjdGlvblNvcnRpbmcuSGVpZ2h0SABSBmhlaWdodBJCCgNmZWUYAiABKAsyLi5jby50b3BsLmdlbnVzLnNlcnZpY2VzLlRyYW5zYWN0aW9uU29ydGluZy5GZWVIAFIDZmVlElQKCXRpbWVzdGFtcBgDIAEoCzI0LmNvLnRvcGwuZ2VudXMuc2VydmljZXMuVHJhbnNhY3Rpb25Tb3J0aW5nLlRpbWVzdGFtcEgAUgl0aW1lc3RhbXAaKAoGSGVpZ2h0Eh4KCmRlc2NlbmRpbmcYASABKAhSCmRlc2NlbmRpbmcaJQoDRmVlEh4KCmRlc2NlbmRpbmcYASABKAhSCmRlc2NlbmRpbmcaKwoJVGltZXN0YW1wEh4KCmRlc2NlbmRpbmcYASABKAhSCmRlc2NlbmRpbmdCCQoHc29ydF9ieQ==');
@$core.Deprecated('Use queryTxsReqDescriptor instead')
const QueryTxsReq$json = const {
  '1': 'QueryTxsReq',
  '2': const [
    const {'1': 'filter', '3': 1, '4': 1, '5': 11, '6': '.co.topl.genus.TransactionFilter', '10': 'filter'},
    const {'1': 'sorting', '3': 2, '4': 1, '5': 11, '6': '.co.topl.genus.services.TransactionSorting', '10': 'sorting'},
    const {'1': 'confirmation_depth', '3': 3, '4': 1, '5': 13, '10': 'confirmationDepth'},
    const {
      '1': 'paging_options',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.Paging',
      '10': 'pagingOptions'
    },
  ],
};

/// Descriptor for `QueryTxsReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryTxsReqDescriptor = $convert.base64Decode(
    'CgtRdWVyeVR4c1JlcRI4CgZmaWx0ZXIYASABKAsyIC5jby50b3BsLmdlbnVzLlRyYW5zYWN0aW9uRmlsdGVyUgZmaWx0ZXISRAoHc29ydGluZxgCIAEoCzIqLmNvLnRvcGwuZ2VudXMuc2VydmljZXMuVHJhbnNhY3Rpb25Tb3J0aW5nUgdzb3J0aW5nEi0KEmNvbmZpcm1hdGlvbl9kZXB0aBgDIAEoDVIRY29uZmlybWF0aW9uRGVwdGgSRQoOcGFnaW5nX29wdGlvbnMYBCABKAsyHi5jby50b3BsLmdlbnVzLnNlcnZpY2VzLlBhZ2luZ1INcGFnaW5nT3B0aW9ucw==');
@$core.Deprecated('Use queryTxsResDescriptor instead')
const QueryTxsRes$json = const {
  '1': 'QueryTxsRes',
  '2': const [
    const {
      '1': 'success',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.QueryTxsRes.Success',
      '9': 0,
      '10': 'success'
    },
    const {
      '1': 'failure',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.QueryTxsRes.Failure',
      '9': 0,
      '10': 'failure'
    },
  ],
  '3': const [QueryTxsRes_Success$json, QueryTxsRes_Failure$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use queryTxsResDescriptor instead')
const QueryTxsRes_Success$json = const {
  '1': 'Success',
  '2': const [
    const {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.co.topl.genus.Transaction', '10': 'transactions'},
  ],
};

@$core.Deprecated('Use queryTxsResDescriptor instead')
const QueryTxsRes_Failure$json = const {
  '1': 'Failure',
  '2': const [
    const {'1': 'data_store_connection_error', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'dataStoreConnectionError'},
    const {'1': 'query_timeout', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'queryTimeout'},
    const {'1': 'invalid_query', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'invalidQuery'},
  ],
  '8': const [
    const {'1': 'reason'},
  ],
};

/// Descriptor for `QueryTxsRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryTxsResDescriptor = $convert.base64Decode(
    'CgtRdWVyeVR4c1JlcxJHCgdzdWNjZXNzGAEgASgLMisuY28udG9wbC5nZW51cy5zZXJ2aWNlcy5RdWVyeVR4c1Jlcy5TdWNjZXNzSABSB3N1Y2Nlc3MSRwoHZmFpbHVyZRgCIAEoCzIrLmNvLnRvcGwuZ2VudXMuc2VydmljZXMuUXVlcnlUeHNSZXMuRmFpbHVyZUgAUgdmYWlsdXJlGkkKB1N1Y2Nlc3MSPgoMdHJhbnNhY3Rpb25zGAEgAygLMhouY28udG9wbC5nZW51cy5UcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zGqIBCgdGYWlsdXJlEj8KG2RhdGFfc3RvcmVfY29ubmVjdGlvbl9lcnJvchgBIAEoCUgAUhhkYXRhU3RvcmVDb25uZWN0aW9uRXJyb3ISJQoNcXVlcnlfdGltZW91dBgCIAEoCUgAUgxxdWVyeVRpbWVvdXQSJQoNaW52YWxpZF9xdWVyeRgDIAEoCUgAUgxpbnZhbGlkUXVlcnlCCAoGcmVhc29uQggKBnJlc3VsdA==');
@$core.Deprecated('Use txsQueryStreamReqDescriptor instead')
const TxsQueryStreamReq$json = const {
  '1': 'TxsQueryStreamReq',
  '2': const [
    const {'1': 'filter', '3': 1, '4': 1, '5': 11, '6': '.co.topl.genus.TransactionFilter', '10': 'filter'},
    const {'1': 'sorting', '3': 4, '4': 1, '5': 11, '6': '.co.topl.genus.services.TransactionSorting', '10': 'sorting'},
    const {'1': 'confirmation_depth', '3': 2, '4': 1, '5': 13, '10': 'confirmationDepth'},
  ],
};

/// Descriptor for `TxsQueryStreamReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List txsQueryStreamReqDescriptor = $convert.base64Decode(
    'ChFUeHNRdWVyeVN0cmVhbVJlcRI4CgZmaWx0ZXIYASABKAsyIC5jby50b3BsLmdlbnVzLlRyYW5zYWN0aW9uRmlsdGVyUgZmaWx0ZXISRAoHc29ydGluZxgEIAEoCzIqLmNvLnRvcGwuZ2VudXMuc2VydmljZXMuVHJhbnNhY3Rpb25Tb3J0aW5nUgdzb3J0aW5nEi0KEmNvbmZpcm1hdGlvbl9kZXB0aBgCIAEoDVIRY29uZmlybWF0aW9uRGVwdGg=');
@$core.Deprecated('Use txsQueryStreamResDescriptor instead')
const TxsQueryStreamRes$json = const {
  '1': 'TxsQueryStreamRes',
  '2': const [
    const {'1': 'tx', '3': 1, '4': 1, '5': 11, '6': '.co.topl.genus.Transaction', '9': 0, '10': 'tx'},
    const {
      '1': 'failure',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.TxsQueryStreamRes.Failure',
      '9': 0,
      '10': 'failure'
    },
  ],
  '3': const [TxsQueryStreamRes_Failure$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use txsQueryStreamResDescriptor instead')
const TxsQueryStreamRes_Failure$json = const {
  '1': 'Failure',
  '2': const [
    const {'1': 'data_store_connection_error', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'dataStoreConnectionError'},
    const {'1': 'invalid_query', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'invalidQuery'},
  ],
  '8': const [
    const {'1': 'reason'},
  ],
};

/// Descriptor for `TxsQueryStreamRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List txsQueryStreamResDescriptor = $convert.base64Decode(
    'ChFUeHNRdWVyeVN0cmVhbVJlcxIsCgJ0eBgBIAEoCzIaLmNvLnRvcGwuZ2VudXMuVHJhbnNhY3Rpb25IAFICdHgSTQoHZmFpbHVyZRgCIAEoCzIxLmNvLnRvcGwuZ2VudXMuc2VydmljZXMuVHhzUXVlcnlTdHJlYW1SZXMuRmFpbHVyZUgAUgdmYWlsdXJlGnsKB0ZhaWx1cmUSPwobZGF0YV9zdG9yZV9jb25uZWN0aW9uX2Vycm9yGAEgASgJSABSGGRhdGFTdG9yZUNvbm5lY3Rpb25FcnJvchIlCg1pbnZhbGlkX3F1ZXJ5GAIgASgJSABSDGludmFsaWRRdWVyeUIICgZyZWFzb25CCAoGcmVzdWx0');
