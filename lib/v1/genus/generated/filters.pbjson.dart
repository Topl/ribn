///
//  Generated code. Do not modify.
//  source: filters.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// Dart imports:
import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use stringSelectionDescriptor instead')
const StringSelection$json = const {
  '1': 'StringSelection',
  '2': const [
    const {'1': 'values', '3': 1, '4': 3, '5': 9, '10': 'values'},
  ],
};

/// Descriptor for `StringSelection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stringSelectionDescriptor =
    $convert.base64Decode('Cg9TdHJpbmdTZWxlY3Rpb24SFgoGdmFsdWVzGAEgAygJUgZ2YWx1ZXM=');
@$core.Deprecated('Use numberRangeDescriptor instead')
const NumberRange$json = const {
  '1': 'NumberRange',
  '2': const [
    const {'1': 'min', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'min'},
    const {'1': 'max', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'max'},
  ],
  '8': const [
    const {'1': 'filter_type'},
  ],
};

/// Descriptor for `NumberRange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List numberRangeDescriptor = $convert
    .base64Decode('CgtOdW1iZXJSYW5nZRISCgNtaW4YASABKARIAFIDbWluEhIKA21heBgCIAEoBEgAUgNtYXhCDQoLZmlsdGVyX3R5cGU=');
@$core.Deprecated('Use numberSelectionDescriptor instead')
const NumberSelection$json = const {
  '1': 'NumberSelection',
  '2': const [
    const {'1': 'values', '3': 1, '4': 3, '5': 4, '10': 'values'},
  ],
};

/// Descriptor for `NumberSelection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List numberSelectionDescriptor =
    $convert.base64Decode('Cg9OdW1iZXJTZWxlY3Rpb24SFgoGdmFsdWVzGAEgAygEUgZ2YWx1ZXM=');
@$core.Deprecated('Use booleanSelectionDescriptor instead')
const BooleanSelection$json = const {
  '1': 'BooleanSelection',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 8, '10': 'value'},
  ],
};

/// Descriptor for `BooleanSelection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List booleanSelectionDescriptor =
    $convert.base64Decode('ChBCb29sZWFuU2VsZWN0aW9uEhQKBXZhbHVlGAEgASgIUgV2YWx1ZQ==');
@$core.Deprecated('Use tokenValueFilterDescriptor instead')
const TokenValueFilter$json = const {
  '1': 'TokenValueFilter',
  '2': const [
    const {
      '1': 'asset_code_selection',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'assetCodeSelection'
    },
    const {
      '1': 'quantity_range',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.NumberRange',
      '9': 0,
      '10': 'quantityRange'
    },
    const {
      '1': 'token_value_type_selection',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'tokenValueTypeSelection'
    },
  ],
  '8': const [
    const {'1': 'filter_type'},
  ],
};

/// Descriptor for `TokenValueFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenValueFilterDescriptor = $convert.base64Decode(
    'ChBUb2tlblZhbHVlRmlsdGVyElIKFGFzc2V0X2NvZGVfc2VsZWN0aW9uGAEgASgLMh4uY28udG9wbC5nZW51cy5TdHJpbmdTZWxlY3Rpb25IAFISYXNzZXRDb2RlU2VsZWN0aW9uEkMKDnF1YW50aXR5X3JhbmdlGAIgASgLMhouY28udG9wbC5nZW51cy5OdW1iZXJSYW5nZUgAUg1xdWFudGl0eVJhbmdlEl0KGnRva2VuX3ZhbHVlX3R5cGVfc2VsZWN0aW9uGAMgASgLMh4uY28udG9wbC5nZW51cy5TdHJpbmdTZWxlY3Rpb25IAFIXdG9rZW5WYWx1ZVR5cGVTZWxlY3Rpb25CDQoLZmlsdGVyX3R5cGU=');
@$core.Deprecated('Use transactionFilterDescriptor instead')
const TransactionFilter$json = const {
  '1': 'TransactionFilter',
  '2': const [
    const {
      '1': 'tx_type_selection',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'txTypeSelection'
    },
    const {
      '1': 'timestamp_range',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.NumberRange',
      '9': 0,
      '10': 'timestampRange'
    },
    const {
      '1': 'input_address_selection',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'inputAddressSelection'
    },
    const {
      '1': 'input_nonce_selection',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.NumberSelection',
      '9': 0,
      '10': 'inputNonceSelection'
    },
    const {
      '1': 'output_token_box_type_selection',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'outputTokenBoxTypeSelection'
    },
    const {
      '1': 'output_token_value_filter',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.TokenValueFilter',
      '9': 0,
      '10': 'outputTokenValueFilter'
    },
    const {
      '1': 'output_address_selection',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'outputAddressSelection'
    },
    const {
      '1': 'minting_selection',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.BooleanSelection',
      '9': 0,
      '10': 'mintingSelection'
    },
    const {
      '1': 'tx_id_selection',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'txIdSelection'
    },
    const {
      '1': 'boxes_to_remove_selection',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'boxesToRemoveSelection'
    },
    const {'1': 'fee_range', '3': 11, '4': 1, '5': 11, '6': '.co.topl.genus.NumberRange', '9': 0, '10': 'feeRange'},
    const {
      '1': 'proposition_selection',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'propositionSelection'
    },
    const {
      '1': 'block_id_selection',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'blockIdSelection'
    },
    const {
      '1': 'block_height_range',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.NumberRange',
      '9': 0,
      '10': 'blockHeightRange'
    },
    const {
      '1': 'and',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.TransactionFilter.AndFilter',
      '9': 0,
      '10': 'and'
    },
    const {'1': 'or', '3': 16, '4': 1, '5': 11, '6': '.co.topl.genus.TransactionFilter.OrFilter', '9': 0, '10': 'or'},
    const {
      '1': 'not',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.TransactionFilter.NotFilter',
      '9': 0,
      '10': 'not'
    },
    const {
      '1': 'all',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.TransactionFilter.AllFilter',
      '9': 0,
      '10': 'all'
    },
  ],
  '3': const [
    TransactionFilter_AndFilter$json,
    TransactionFilter_OrFilter$json,
    TransactionFilter_NotFilter$json,
    TransactionFilter_AllFilter$json
  ],
  '8': const [
    const {'1': 'filter_type'},
  ],
};

@$core.Deprecated('Use transactionFilterDescriptor instead')
const TransactionFilter_AndFilter$json = const {
  '1': 'AndFilter',
  '2': const [
    const {'1': 'filters', '3': 1, '4': 3, '5': 11, '6': '.co.topl.genus.TransactionFilter', '10': 'filters'},
  ],
};

@$core.Deprecated('Use transactionFilterDescriptor instead')
const TransactionFilter_OrFilter$json = const {
  '1': 'OrFilter',
  '2': const [
    const {'1': 'filters', '3': 1, '4': 3, '5': 11, '6': '.co.topl.genus.TransactionFilter', '10': 'filters'},
  ],
};

@$core.Deprecated('Use transactionFilterDescriptor instead')
const TransactionFilter_NotFilter$json = const {
  '1': 'NotFilter',
  '2': const [
    const {'1': 'filter', '3': 1, '4': 1, '5': 11, '6': '.co.topl.genus.TransactionFilter', '10': 'filter'},
  ],
};

@$core.Deprecated('Use transactionFilterDescriptor instead')
const TransactionFilter_AllFilter$json = const {
  '1': 'AllFilter',
};

/// Descriptor for `TransactionFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionFilterDescriptor = $convert.base64Decode(
    'ChFUcmFuc2FjdGlvbkZpbHRlchJMChF0eF90eXBlX3NlbGVjdGlvbhgBIAEoCzIeLmNvLnRvcGwuZ2VudXMuU3RyaW5nU2VsZWN0aW9uSABSD3R4VHlwZVNlbGVjdGlvbhJFCg90aW1lc3RhbXBfcmFuZ2UYAiABKAsyGi5jby50b3BsLmdlbnVzLk51bWJlclJhbmdlSABSDnRpbWVzdGFtcFJhbmdlElgKF2lucHV0X2FkZHJlc3Nfc2VsZWN0aW9uGAMgASgLMh4uY28udG9wbC5nZW51cy5TdHJpbmdTZWxlY3Rpb25IAFIVaW5wdXRBZGRyZXNzU2VsZWN0aW9uElQKFWlucHV0X25vbmNlX3NlbGVjdGlvbhgEIAEoCzIeLmNvLnRvcGwuZ2VudXMuTnVtYmVyU2VsZWN0aW9uSABSE2lucHV0Tm9uY2VTZWxlY3Rpb24SZgofb3V0cHV0X3Rva2VuX2JveF90eXBlX3NlbGVjdGlvbhgFIAEoCzIeLmNvLnRvcGwuZ2VudXMuU3RyaW5nU2VsZWN0aW9uSABSG291dHB1dFRva2VuQm94VHlwZVNlbGVjdGlvbhJcChlvdXRwdXRfdG9rZW5fdmFsdWVfZmlsdGVyGAYgASgLMh8uY28udG9wbC5nZW51cy5Ub2tlblZhbHVlRmlsdGVySABSFm91dHB1dFRva2VuVmFsdWVGaWx0ZXISWgoYb3V0cHV0X2FkZHJlc3Nfc2VsZWN0aW9uGAcgASgLMh4uY28udG9wbC5nZW51cy5TdHJpbmdTZWxlY3Rpb25IAFIWb3V0cHV0QWRkcmVzc1NlbGVjdGlvbhJOChFtaW50aW5nX3NlbGVjdGlvbhgIIAEoCzIfLmNvLnRvcGwuZ2VudXMuQm9vbGVhblNlbGVjdGlvbkgAUhBtaW50aW5nU2VsZWN0aW9uEkgKD3R4X2lkX3NlbGVjdGlvbhgJIAEoCzIeLmNvLnRvcGwuZ2VudXMuU3RyaW5nU2VsZWN0aW9uSABSDXR4SWRTZWxlY3Rpb24SWwoZYm94ZXNfdG9fcmVtb3ZlX3NlbGVjdGlvbhgKIAEoCzIeLmNvLnRvcGwuZ2VudXMuU3RyaW5nU2VsZWN0aW9uSABSFmJveGVzVG9SZW1vdmVTZWxlY3Rpb24SOQoJZmVlX3JhbmdlGAsgASgLMhouY28udG9wbC5nZW51cy5OdW1iZXJSYW5nZUgAUghmZWVSYW5nZRJVChVwcm9wb3NpdGlvbl9zZWxlY3Rpb24YDCABKAsyHi5jby50b3BsLmdlbnVzLlN0cmluZ1NlbGVjdGlvbkgAUhRwcm9wb3NpdGlvblNlbGVjdGlvbhJOChJibG9ja19pZF9zZWxlY3Rpb24YDSABKAsyHi5jby50b3BsLmdlbnVzLlN0cmluZ1NlbGVjdGlvbkgAUhBibG9ja0lkU2VsZWN0aW9uEkoKEmJsb2NrX2hlaWdodF9yYW5nZRgOIAEoCzIaLmNvLnRvcGwuZ2VudXMuTnVtYmVyUmFuZ2VIAFIQYmxvY2tIZWlnaHRSYW5nZRI+CgNhbmQYDyABKAsyKi5jby50b3BsLmdlbnVzLlRyYW5zYWN0aW9uRmlsdGVyLkFuZEZpbHRlckgAUgNhbmQSOwoCb3IYECABKAsyKS5jby50b3BsLmdlbnVzLlRyYW5zYWN0aW9uRmlsdGVyLk9yRmlsdGVySABSAm9yEj4KA25vdBgRIAEoCzIqLmNvLnRvcGwuZ2VudXMuVHJhbnNhY3Rpb25GaWx0ZXIuTm90RmlsdGVySABSA25vdBI+CgNhbGwYEiABKAsyKi5jby50b3BsLmdlbnVzLlRyYW5zYWN0aW9uRmlsdGVyLkFsbEZpbHRlckgAUgNhbGwaRwoJQW5kRmlsdGVyEjoKB2ZpbHRlcnMYASADKAsyIC5jby50b3BsLmdlbnVzLlRyYW5zYWN0aW9uRmlsdGVyUgdmaWx0ZXJzGkYKCE9yRmlsdGVyEjoKB2ZpbHRlcnMYASADKAsyIC5jby50b3BsLmdlbnVzLlRyYW5zYWN0aW9uRmlsdGVyUgdmaWx0ZXJzGkUKCU5vdEZpbHRlchI4CgZmaWx0ZXIYASABKAsyIC5jby50b3BsLmdlbnVzLlRyYW5zYWN0aW9uRmlsdGVyUgZmaWx0ZXIaCwoJQWxsRmlsdGVyQg0KC2ZpbHRlcl90eXBl');
@$core.Deprecated('Use blockFilterDescriptor instead')
const BlockFilter$json = const {
  '1': 'BlockFilter',
  '2': const [
    const {
      '1': 'id_selection',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'idSelection'
    },
    const {
      '1': 'parent_id_selection',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'parentIdSelection'
    },
    const {
      '1': 'timestamp_range',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.NumberRange',
      '9': 0,
      '10': 'timestampRange'
    },
    const {
      '1': 'generator_box_token_value_filter',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.TokenValueFilter',
      '9': 0,
      '10': 'generatorBoxTokenValueFilter'
    },
    const {
      '1': 'public_key_selection',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.StringSelection',
      '9': 0,
      '10': 'publicKeySelection'
    },
    const {
      '1': 'height_range',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.NumberRange',
      '9': 0,
      '10': 'heightRange'
    },
    const {
      '1': 'height_selection',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.NumberSelection',
      '9': 0,
      '10': 'heightSelection'
    },
    const {
      '1': 'difficulty_range',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.NumberRange',
      '9': 0,
      '10': 'difficultyRange'
    },
    const {
      '1': 'version_selection',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.NumberSelection',
      '9': 0,
      '10': 'versionSelection'
    },
    const {
      '1': 'num_transaction_range',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.NumberRange',
      '9': 0,
      '10': 'numTransactionRange'
    },
    const {'1': 'and', '3': 15, '4': 1, '5': 11, '6': '.co.topl.genus.BlockFilter.AndFilter', '9': 0, '10': 'and'},
    const {'1': 'or', '3': 16, '4': 1, '5': 11, '6': '.co.topl.genus.BlockFilter.OrFilter', '9': 0, '10': 'or'},
    const {'1': 'not', '3': 17, '4': 1, '5': 11, '6': '.co.topl.genus.BlockFilter.NotFilter', '9': 0, '10': 'not'},
    const {'1': 'all', '3': 18, '4': 1, '5': 11, '6': '.co.topl.genus.BlockFilter.AllFilter', '9': 0, '10': 'all'},
  ],
  '3': const [
    BlockFilter_AndFilter$json,
    BlockFilter_OrFilter$json,
    BlockFilter_NotFilter$json,
    BlockFilter_AllFilter$json
  ],
  '8': const [
    const {'1': 'filter_type'},
  ],
};

@$core.Deprecated('Use blockFilterDescriptor instead')
const BlockFilter_AndFilter$json = const {
  '1': 'AndFilter',
  '2': const [
    const {'1': 'filters', '3': 1, '4': 3, '5': 11, '6': '.co.topl.genus.BlockFilter', '10': 'filters'},
  ],
};

@$core.Deprecated('Use blockFilterDescriptor instead')
const BlockFilter_OrFilter$json = const {
  '1': 'OrFilter',
  '2': const [
    const {'1': 'filters', '3': 1, '4': 3, '5': 11, '6': '.co.topl.genus.BlockFilter', '10': 'filters'},
  ],
};

@$core.Deprecated('Use blockFilterDescriptor instead')
const BlockFilter_NotFilter$json = const {
  '1': 'NotFilter',
  '2': const [
    const {'1': 'filter', '3': 1, '4': 1, '5': 11, '6': '.co.topl.genus.BlockFilter', '10': 'filter'},
  ],
};

@$core.Deprecated('Use blockFilterDescriptor instead')
const BlockFilter_AllFilter$json = const {
  '1': 'AllFilter',
};

/// Descriptor for `BlockFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockFilterDescriptor = $convert.base64Decode(
    'CgtCbG9ja0ZpbHRlchJDCgxpZF9zZWxlY3Rpb24YASABKAsyHi5jby50b3BsLmdlbnVzLlN0cmluZ1NlbGVjdGlvbkgAUgtpZFNlbGVjdGlvbhJQChNwYXJlbnRfaWRfc2VsZWN0aW9uGAIgASgLMh4uY28udG9wbC5nZW51cy5TdHJpbmdTZWxlY3Rpb25IAFIRcGFyZW50SWRTZWxlY3Rpb24SRQoPdGltZXN0YW1wX3JhbmdlGAMgASgLMhouY28udG9wbC5nZW51cy5OdW1iZXJSYW5nZUgAUg50aW1lc3RhbXBSYW5nZRJpCiBnZW5lcmF0b3JfYm94X3Rva2VuX3ZhbHVlX2ZpbHRlchgEIAEoCzIfLmNvLnRvcGwuZ2VudXMuVG9rZW5WYWx1ZUZpbHRlckgAUhxnZW5lcmF0b3JCb3hUb2tlblZhbHVlRmlsdGVyElIKFHB1YmxpY19rZXlfc2VsZWN0aW9uGAUgASgLMh4uY28udG9wbC5nZW51cy5TdHJpbmdTZWxlY3Rpb25IAFIScHVibGljS2V5U2VsZWN0aW9uEj8KDGhlaWdodF9yYW5nZRgGIAEoCzIaLmNvLnRvcGwuZ2VudXMuTnVtYmVyUmFuZ2VIAFILaGVpZ2h0UmFuZ2USSwoQaGVpZ2h0X3NlbGVjdGlvbhgHIAEoCzIeLmNvLnRvcGwuZ2VudXMuTnVtYmVyU2VsZWN0aW9uSABSD2hlaWdodFNlbGVjdGlvbhJHChBkaWZmaWN1bHR5X3JhbmdlGAggASgLMhouY28udG9wbC5nZW51cy5OdW1iZXJSYW5nZUgAUg9kaWZmaWN1bHR5UmFuZ2USTQoRdmVyc2lvbl9zZWxlY3Rpb24YCSABKAsyHi5jby50b3BsLmdlbnVzLk51bWJlclNlbGVjdGlvbkgAUhB2ZXJzaW9uU2VsZWN0aW9uElAKFW51bV90cmFuc2FjdGlvbl9yYW5nZRgKIAEoCzIaLmNvLnRvcGwuZ2VudXMuTnVtYmVyUmFuZ2VIAFITbnVtVHJhbnNhY3Rpb25SYW5nZRI4CgNhbmQYDyABKAsyJC5jby50b3BsLmdlbnVzLkJsb2NrRmlsdGVyLkFuZEZpbHRlckgAUgNhbmQSNQoCb3IYECABKAsyIy5jby50b3BsLmdlbnVzLkJsb2NrRmlsdGVyLk9yRmlsdGVySABSAm9yEjgKA25vdBgRIAEoCzIkLmNvLnRvcGwuZ2VudXMuQmxvY2tGaWx0ZXIuTm90RmlsdGVySABSA25vdBI4CgNhbGwYEiABKAsyJC5jby50b3BsLmdlbnVzLkJsb2NrRmlsdGVyLkFsbEZpbHRlckgAUgNhbGwaQQoJQW5kRmlsdGVyEjQKB2ZpbHRlcnMYASADKAsyGi5jby50b3BsLmdlbnVzLkJsb2NrRmlsdGVyUgdmaWx0ZXJzGkAKCE9yRmlsdGVyEjQKB2ZpbHRlcnMYASADKAsyGi5jby50b3BsLmdlbnVzLkJsb2NrRmlsdGVyUgdmaWx0ZXJzGj8KCU5vdEZpbHRlchIyCgZmaWx0ZXIYASABKAsyGi5jby50b3BsLmdlbnVzLkJsb2NrRmlsdGVyUgZmaWx0ZXIaCwoJQWxsRmlsdGVyQg0KC2ZpbHRlcl90eXBl');
