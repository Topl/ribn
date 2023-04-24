// TODO SDK, I dont think Network is the proper term
enum Network {
  topl_mainnet(
    name: 'Topl Mainnet',
  ),
  valhalla_testnet(
    name: 'Valhalla Testnet',
  ),
  private_network(
    name: 'Private Network',
  );

  const Network({
    required this.name,
  });

  final String name;
}
