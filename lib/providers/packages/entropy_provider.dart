import 'package:bip_topl/bip_topl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinenacl/encoding.dart';

final entropyProvider = Provider<Entropy Function(dynamic)>((ref) {
  return (random) => Entropy.generate(from_entropy_size(128), RandomBridge(random).nextUint8);
});

final entropyFuncProvider = Provider<String Function(dynamic)>((ref) {
  return (entropy) =>
      entropyToMnemonic(HexCoder.instance.encode(entropy.bytes), language: 'english');
});
