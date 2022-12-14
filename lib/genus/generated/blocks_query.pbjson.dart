///
//  Generated code. Do not modify.
//  source: blocks_query.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use blockSortingDescriptor instead')
const BlockSorting$json = const {
  '1': 'BlockSorting',
  '2': const [
    const {
      '1': 'height',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.BlockSorting.Height',
      '9': 0,
      '10': 'height'
    },
    const {
      '1': 'timestamp',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.BlockSorting.Timestamp',
      '9': 0,
      '10': 'timestamp'
    },
    const {
      '1': 'difficulty',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.BlockSorting.Difficulty',
      '9': 0,
      '10': 'difficulty'
    },
    const {
      '1': 'number_of_transactions',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.BlockSorting.NumberOfTransactions',
      '9': 0,
      '10': 'numberOfTransactions'
    },
  ],
  '3': const [
    BlockSorting_Height$json,
    BlockSorting_Timestamp$json,
    BlockSorting_Difficulty$json,
    BlockSorting_NumberOfTransactions$json
  ],
  '8': const [
    const {'1': 'sort_by'},
  ],
};

@$core.Deprecated('Use blockSortingDescriptor instead')
const BlockSorting_Height$json = const {
  '1': 'Height',
  '2': const [
    const {'1': 'descending', '3': 1, '4': 1, '5': 8, '10': 'descending'},
  ],
};

@$core.Deprecated('Use blockSortingDescriptor instead')
const BlockSorting_Timestamp$json = const {
  '1': 'Timestamp',
  '2': const [
    const {'1': 'descending', '3': 1, '4': 1, '5': 8, '10': 'descending'},
  ],
};

@$core.Deprecated('Use blockSortingDescriptor instead')
const BlockSorting_Difficulty$json = const {
  '1': 'Difficulty',
  '2': const [
    const {'1': 'descending', '3': 1, '4': 1, '5': 8, '10': 'descending'},
  ],
};

@$core.Deprecated('Use blockSortingDescriptor instead')
const BlockSorting_NumberOfTransactions$json = const {
  '1': 'NumberOfTransactions',
  '2': const [
    const {'1': 'descending', '3': 1, '4': 1, '5': 8, '10': 'descending'},
  ],
};

/// Descriptor for `BlockSorting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockSortingDescriptor = $convert.base64Decode(
    'CgxCbG9ja1NvcnRpbmcSRQoGaGVpZ2h0GAEgASgLMisuY28udG9wbC5nZW51cy5zZXJ2aWNlcy5CbG9ja1NvcnRpbmcuSGVpZ2h0SABSBmhlaWdodBJOCgl0aW1lc3RhbXAYAiABKAsyLi5jby50b3BsLmdlbnVzLnNlcnZpY2VzLkJsb2NrU29ydGluZy5UaW1lc3RhbXBIAFIJdGltZXN0YW1wElEKCmRpZmZpY3VsdHkYAyABKAsyLy5jby50b3BsLmdlbnVzLnNlcnZpY2VzLkJsb2NrU29ydGluZy5EaWZmaWN1bHR5SABSCmRpZmZpY3VsdHkScQoWbnVtYmVyX29mX3RyYW5zYWN0aW9ucxgEIAEoCzI5LmNvLnRvcGwuZ2VudXMuc2VydmljZXMuQmxvY2tTb3J0aW5nLk51bWJlck9mVHJhbnNhY3Rpb25zSABSFG51bWJlck9mVHJhbnNhY3Rpb25zGigKBkhlaWdodBIeCgpkZXNjZW5kaW5nGAEgASgIUgpkZXNjZW5kaW5nGisKCVRpbWVzdGFtcBIeCgpkZXNjZW5kaW5nGAEgASgIUgpkZXNjZW5kaW5nGiwKCkRpZmZpY3VsdHkSHgoKZGVzY2VuZGluZxgBIAEoCFIKZGVzY2VuZGluZxo2ChROdW1iZXJPZlRyYW5zYWN0aW9ucxIeCgpkZXNjZW5kaW5nGAEgASgIUgpkZXNjZW5kaW5nQgkKB3NvcnRfYnk=');
@$core.Deprecated('Use queryBlocksReqDescriptor instead')
const QueryBlocksReq$json = const {
  '1': 'QueryBlocksReq',
  '2': const [
    const {
      '1': 'filter',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.BlockFilter',
      '10': 'filter'
    },
    const {
      '1': 'sorting',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.BlockSorting',
      '10': 'sorting'
    },
    const {
      '1': 'confirmation_depth',
      '3': 3,
      '4': 1,
      '5': 13,
      '10': 'confirmationDepth'
    },
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

/// Descriptor for `QueryBlocksReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryBlocksReqDescriptor = $convert.base64Decode(
    'Cg5RdWVyeUJsb2Nrc1JlcRIyCgZmaWx0ZXIYASABKAsyGi5jby50b3BsLmdlbnVzLkJsb2NrRmlsdGVyUgZmaWx0ZXISPgoHc29ydGluZxgCIAEoCzIkLmNvLnRvcGwuZ2VudXMuc2VydmljZXMuQmxvY2tTb3J0aW5nUgdzb3J0aW5nEi0KEmNvbmZpcm1hdGlvbl9kZXB0aBgDIAEoDVIRY29uZmlybWF0aW9uRGVwdGgSRQoOcGFnaW5nX29wdGlvbnMYBCABKAsyHi5jby50b3BsLmdlbnVzLnNlcnZpY2VzLlBhZ2luZ1INcGFnaW5nT3B0aW9ucw==');
@$core.Deprecated('Use queryBlocksResDescriptor instead')
const QueryBlocksRes$json = const {
  '1': 'QueryBlocksRes',
  '2': const [
    const {
      '1': 'success',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.QueryBlocksRes.Success',
      '9': 0,
      '10': 'success'
    },
    const {
      '1': 'failure',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.QueryBlocksRes.Failure',
      '9': 0,
      '10': 'failure'
    },
  ],
  '3': const [QueryBlocksRes_Success$json, QueryBlocksRes_Failure$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use queryBlocksResDescriptor instead')
const QueryBlocksRes_Success$json = const {
  '1': 'Success',
  '2': const [
    const {
      '1': 'blocks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.co.topl.genus.Block',
      '10': 'blocks'
    },
  ],
};

@$core.Deprecated('Use queryBlocksResDescriptor instead')
const QueryBlocksRes_Failure$json = const {
  '1': 'Failure',
  '2': const [
    const {
      '1': 'data_store_connection_error',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'dataStoreConnectionError'
    },
    const {
      '1': 'query_timeout',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'queryTimeout'
    },
    const {
      '1': 'invalid_query',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'invalidQuery'
    },
  ],
  '8': const [
    const {'1': 'reason'},
  ],
};

/// Descriptor for `QueryBlocksRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryBlocksResDescriptor = $convert.base64Decode(
    'Cg5RdWVyeUJsb2Nrc1JlcxJKCgdzdWNjZXNzGAEgASgLMi4uY28udG9wbC5nZW51cy5zZXJ2aWNlcy5RdWVyeUJsb2Nrc1Jlcy5TdWNjZXNzSABSB3N1Y2Nlc3MSSgoHZmFpbHVyZRgCIAEoCzIuLmNvLnRvcGwuZ2VudXMuc2VydmljZXMuUXVlcnlCbG9ja3NSZXMuRmFpbHVyZUgAUgdmYWlsdXJlGjcKB1N1Y2Nlc3MSLAoGYmxvY2tzGAEgAygLMhQuY28udG9wbC5nZW51cy5CbG9ja1IGYmxvY2tzGqIBCgdGYWlsdXJlEj8KG2RhdGFfc3RvcmVfY29ubmVjdGlvbl9lcnJvchgBIAEoCUgAUhhkYXRhU3RvcmVDb25uZWN0aW9uRXJyb3ISJQoNcXVlcnlfdGltZW91dBgCIAEoCUgAUgxxdWVyeVRpbWVvdXQSJQoNaW52YWxpZF9xdWVyeRgDIAEoCUgAUgxpbnZhbGlkUXVlcnlCCAoGcmVhc29uQggKBnJlc3VsdA==');
@$core.Deprecated('Use blocksQueryStreamReqDescriptor instead')
const BlocksQueryStreamReq$json = const {
  '1': 'BlocksQueryStreamReq',
  '2': const [
    const {
      '1': 'filter',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.BlockFilter',
      '10': 'filter'
    },
    const {
      '1': 'sorting',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.BlockSorting',
      '10': 'sorting'
    },
    const {
      '1': 'confirmation_depth',
      '3': 3,
      '4': 1,
      '5': 13,
      '10': 'confirmationDepth'
    },
  ],
};

/// Descriptor for `BlocksQueryStreamReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blocksQueryStreamReqDescriptor = $convert.base64Decode(
    'ChRCbG9ja3NRdWVyeVN0cmVhbVJlcRIyCgZmaWx0ZXIYASABKAsyGi5jby50b3BsLmdlbnVzLkJsb2NrRmlsdGVyUgZmaWx0ZXISPgoHc29ydGluZxgCIAEoCzIkLmNvLnRvcGwuZ2VudXMuc2VydmljZXMuQmxvY2tTb3J0aW5nUgdzb3J0aW5nEi0KEmNvbmZpcm1hdGlvbl9kZXB0aBgDIAEoDVIRY29uZmlybWF0aW9uRGVwdGg=');
@$core.Deprecated('Use blocksQueryStreamResDescriptor instead')
const BlocksQueryStreamRes$json = const {
  '1': 'BlocksQueryStreamRes',
  '2': const [
    const {
      '1': 'block',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.Block',
      '9': 0,
      '10': 'block'
    },
    const {
      '1': 'failure',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.services.BlocksQueryStreamRes.Failure',
      '9': 0,
      '10': 'failure'
    },
  ],
  '3': const [BlocksQueryStreamRes_Failure$json],
  '8': const [
    const {'1': 'result'},
  ],
};

@$core.Deprecated('Use blocksQueryStreamResDescriptor instead')
const BlocksQueryStreamRes_Failure$json = const {
  '1': 'Failure',
  '2': const [
    const {
      '1': 'data_store_connection_error',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'dataStoreConnectionError'
    },
    const {
      '1': 'invalid_query',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'invalidQuery'
    },
  ],
  '8': const [
    const {'1': 'reason'},
  ],
};

/// Descriptor for `BlocksQueryStreamRes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blocksQueryStreamResDescriptor = $convert.base64Decode(
    'ChRCbG9ja3NRdWVyeVN0cmVhbVJlcxIsCgVibG9jaxgBIAEoCzIULmNvLnRvcGwuZ2VudXMuQmxvY2tIAFIFYmxvY2sSUAoHZmFpbHVyZRgCIAEoCzI0LmNvLnRvcGwuZ2VudXMuc2VydmljZXMuQmxvY2tzUXVlcnlTdHJlYW1SZXMuRmFpbHVyZUgAUgdmYWlsdXJlGnsKB0ZhaWx1cmUSPwobZGF0YV9zdG9yZV9jb25uZWN0aW9uX2Vycm9yGAEgASgJSABSGGRhdGFTdG9yZUNvbm5lY3Rpb25FcnJvchIlCg1pbnZhbGlkX3F1ZXJ5GAIgASgJSABSDGludmFsaWRRdWVyeUIICgZyZWFzb25CCAoGcmVzdWx0');
