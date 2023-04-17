// TODO SDK, I dont think Keychain is the proper term
enum Keychain {
  topl_mainnet(
    name: 'Topl Mainnet',
  ),
  valhalla_testnet(
    name: 'Valhalla Testnet',
  ),
  private_network(
    name: 'Private Network',
  );

  const Keychain({
    required this.name,
  });

  final String name;
}
