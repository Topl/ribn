///
//  Generated code. Do not modify.
//  source: types.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// Dart imports:
import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use attestationDescriptor instead')
const Attestation$json = const {
  '1': 'Attestation',
  '2': const [
    const {'1': 'public_key', '3': 1, '4': 1, '5': 9, '10': 'publicKey'},
    const {'1': 'signature', '3': 2, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `Attestation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List attestationDescriptor = $convert.base64Decode(
    'CgtBdHRlc3RhdGlvbhIdCgpwdWJsaWNfa2V5GAEgASgJUglwdWJsaWNLZXkSHAoJc2lnbmF0dXJlGAIgASgJUglzaWduYXR1cmU=');
@$core.Deprecated('Use simpleValueDescriptor instead')
const SimpleValue$json = const {
  '1': 'SimpleValue',
  '2': const [
    const {'1': 'quantity', '3': 1, '4': 1, '5': 9, '10': 'quantity'},
  ],
};

/// Descriptor for `SimpleValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simpleValueDescriptor = $convert
    .base64Decode('CgtTaW1wbGVWYWx1ZRIaCghxdWFudGl0eRgBIAEoCVIIcXVhbnRpdHk=');
@$core.Deprecated('Use assetValueDescriptor instead')
const AssetValue$json = const {
  '1': 'AssetValue',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'quantity', '3': 2, '4': 1, '5': 9, '10': 'quantity'},
    const {'1': 'security_root', '3': 3, '4': 1, '5': 9, '10': 'securityRoot'},
    const {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `AssetValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetValueDescriptor = $convert.base64Decode(
    'CgpBc3NldFZhbHVlEhIKBGNvZGUYASABKAlSBGNvZGUSGgoIcXVhbnRpdHkYAiABKAlSCHF1YW50aXR5EiMKDXNlY3VyaXR5X3Jvb3QYAyABKAlSDHNlY3VyaXR5Um9vdBIaCghtZXRhZGF0YRgEIAEoCVIIbWV0YWRhdGE=');
@$core.Deprecated('Use tokenValueDescriptor instead')
const TokenValue$json = const {
  '1': 'TokenValue',
  '2': const [
    const {
      '1': 'simple',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.SimpleValue',
      '9': 0,
      '10': 'simple'
    },
    const {
      '1': 'asset',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.AssetValue',
      '9': 0,
      '10': 'asset'
    },
  ],
  '8': const [
    const {'1': 'value'},
  ],
};

/// Descriptor for `TokenValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenValueDescriptor = $convert.base64Decode(
    'CgpUb2tlblZhbHVlEjQKBnNpbXBsZRgBIAEoCzIaLmNvLnRvcGwuZ2VudXMuU2ltcGxlVmFsdWVIAFIGc2ltcGxlEjEKBWFzc2V0GAIgASgLMhkuY28udG9wbC5nZW51cy5Bc3NldFZhbHVlSABSBWFzc2V0QgcKBXZhbHVl');
@$core.Deprecated('Use tokenBoxDescriptor instead')
const TokenBox$json = const {
  '1': 'TokenBox',
  '2': const [
    const {'1': 'box_type', '3': 1, '4': 1, '5': 9, '10': 'boxType'},
    const {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'nonce', '3': 3, '4': 1, '5': 9, '10': 'nonce'},
    const {'1': 'evidence', '3': 4, '4': 1, '5': 9, '10': 'evidence'},
    const {
      '1': 'value',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.TokenValue',
      '10': 'value'
    },
  ],
};

/// Descriptor for `TokenBox`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenBoxDescriptor = $convert.base64Decode(
    'CghUb2tlbkJveBIZCghib3hfdHlwZRgBIAEoCVIHYm94VHlwZRIOCgJpZBgCIAEoCVICaWQSFAoFbm9uY2UYAyABKAlSBW5vbmNlEhoKCGV2aWRlbmNlGAQgASgJUghldmlkZW5jZRIvCgV2YWx1ZRgFIAEoCzIZLmNvLnRvcGwuZ2VudXMuVG9rZW5WYWx1ZVIFdmFsdWU=');
@$core.Deprecated('Use inputBoxDescriptor instead')
const InputBox$json = const {
  '1': 'InputBox',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'nonce', '3': 2, '4': 1, '5': 9, '10': 'nonce'},
  ],
};

/// Descriptor for `InputBox`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inputBoxDescriptor = $convert.base64Decode(
    'CghJbnB1dEJveBIYCgdhZGRyZXNzGAEgASgJUgdhZGRyZXNzEhQKBW5vbmNlGAIgASgJUgVub25jZQ==');
@$core.Deprecated('Use outputBoxDescriptor instead')
const OutputBox$json = const {
  '1': 'OutputBox',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
    const {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.TokenValue',
      '10': 'value'
    },
  ],
};

/// Descriptor for `OutputBox`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List outputBoxDescriptor = $convert.base64Decode(
    'CglPdXRwdXRCb3gSGAoHYWRkcmVzcxgBIAEoCVIHYWRkcmVzcxIvCgV2YWx1ZRgCIAEoCzIZLmNvLnRvcGwuZ2VudXMuVG9rZW5WYWx1ZVIFdmFsdWU=');
@$core.Deprecated('Use blockHeightDescriptor instead')
const BlockHeight$json = const {
  '1': 'BlockHeight',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `BlockHeight`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockHeightDescriptor =
    $convert.base64Decode('CgtCbG9ja0hlaWdodBIUCgV2YWx1ZRgBIAEoBFIFdmFsdWU=');
@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = const {
  '1': 'Transaction',
  '2': const [
    const {'1': 'tx_type', '3': 1, '4': 1, '5': 9, '10': 'txType'},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 9, '10': 'timestamp'},
    const {
      '1': 'signatures',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.co.topl.genus.Attestation',
      '10': 'signatures'
    },
    const {
      '1': 'new_boxes',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.co.topl.genus.TokenBox',
      '10': 'newBoxes'
    },
    const {'1': 'data', '3': 5, '4': 1, '5': 9, '10': 'data'},
    const {
      '1': 'inputs',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.co.topl.genus.InputBox',
      '10': 'inputs'
    },
    const {'1': 'minting', '3': 7, '4': 1, '5': 8, '10': 'minting'},
    const {'1': 'tx_id', '3': 8, '4': 1, '5': 9, '10': 'txId'},
    const {
      '1': 'boxes_to_remove',
      '3': 9,
      '4': 3,
      '5': 9,
      '10': 'boxesToRemove'
    },
    const {'1': 'fee', '3': 10, '4': 1, '5': 9, '10': 'fee'},
    const {
      '1': 'outputs',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.co.topl.genus.OutputBox',
      '10': 'outputs'
    },
    const {
      '1': 'proposition_type',
      '3': 12,
      '4': 1,
      '5': 9,
      '10': 'propositionType'
    },
    const {'1': 'block_id', '3': 13, '4': 1, '5': 9, '10': 'blockId'},
    const {'1': 'block_height', '3': 14, '4': 1, '5': 4, '10': 'blockHeight'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode(
    'CgtUcmFuc2FjdGlvbhIXCgd0eF90eXBlGAEgASgJUgZ0eFR5cGUSHAoJdGltZXN0YW1wGAIgASgJUgl0aW1lc3RhbXASOgoKc2lnbmF0dXJlcxgDIAMoCzIaLmNvLnRvcGwuZ2VudXMuQXR0ZXN0YXRpb25SCnNpZ25hdHVyZXMSNAoJbmV3X2JveGVzGAQgAygLMhcuY28udG9wbC5nZW51cy5Ub2tlbkJveFIIbmV3Qm94ZXMSEgoEZGF0YRgFIAEoCVIEZGF0YRIvCgZpbnB1dHMYBiADKAsyFy5jby50b3BsLmdlbnVzLklucHV0Qm94UgZpbnB1dHMSGAoHbWludGluZxgHIAEoCFIHbWludGluZxITCgV0eF9pZBgIIAEoCVIEdHhJZBImCg9ib3hlc190b19yZW1vdmUYCSADKAlSDWJveGVzVG9SZW1vdmUSEAoDZmVlGAogASgJUgNmZWUSMgoHb3V0cHV0cxgLIAMoCzIYLmNvLnRvcGwuZ2VudXMuT3V0cHV0Qm94UgdvdXRwdXRzEikKEHByb3Bvc2l0aW9uX3R5cGUYDCABKAlSD3Byb3Bvc2l0aW9uVHlwZRIZCghibG9ja19pZBgNIAEoCVIHYmxvY2tJZBIhCgxibG9ja19oZWlnaHQYDiABKARSC2Jsb2NrSGVpZ2h0');
@$core.Deprecated('Use blockDescriptor instead')
const Block$json = const {
  '1': 'Block',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'parent_id', '3': 2, '4': 1, '5': 9, '10': 'parentId'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 9, '10': 'timestamp'},
    const {
      '1': 'generator',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.co.topl.genus.TokenBox',
      '10': 'generator'
    },
    const {'1': 'public_key', '3': 5, '4': 1, '5': 9, '10': 'publicKey'},
    const {'1': 'signature', '3': 6, '4': 1, '5': 9, '10': 'signature'},
    const {'1': 'height', '3': 7, '4': 1, '5': 4, '10': 'height'},
    const {'1': 'difficulty', '3': 8, '4': 1, '5': 9, '10': 'difficulty'},
    const {'1': 'tx_root', '3': 9, '4': 1, '5': 9, '10': 'txRoot'},
    const {'1': 'bloom_filter', '3': 10, '4': 1, '5': 9, '10': 'bloomFilter'},
    const {'1': 'version', '3': 11, '4': 1, '5': 13, '10': 'version'},
    const {
      '1': 'num_transactions',
      '3': 12,
      '4': 1,
      '5': 13,
      '10': 'numTransactions'
    },
  ],
};

/// Descriptor for `Block`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockDescriptor = $convert.base64Decode(
    'CgVCbG9jaxIOCgJpZBgBIAEoCVICaWQSGwoJcGFyZW50X2lkGAIgASgJUghwYXJlbnRJZBIcCgl0aW1lc3RhbXAYAyABKAlSCXRpbWVzdGFtcBI1CglnZW5lcmF0b3IYBCABKAsyFy5jby50b3BsLmdlbnVzLlRva2VuQm94UglnZW5lcmF0b3ISHQoKcHVibGljX2tleRgFIAEoCVIJcHVibGljS2V5EhwKCXNpZ25hdHVyZRgGIAEoCVIJc2lnbmF0dXJlEhYKBmhlaWdodBgHIAEoBFIGaGVpZ2h0Eh4KCmRpZmZpY3VsdHkYCCABKAlSCmRpZmZpY3VsdHkSFwoHdHhfcm9vdBgJIAEoCVIGdHhSb290EiEKDGJsb29tX2ZpbHRlchgKIAEoCVILYmxvb21GaWx0ZXISGAoHdmVyc2lvbhgLIAEoDVIHdmVyc2lvbhIpChBudW1fdHJhbnNhY3Rpb25zGAwgASgNUg9udW1UcmFuc2FjdGlvbnM=');
