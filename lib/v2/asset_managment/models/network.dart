// TODO SDK, I dont think Network is the proper term
enum Network {
  topl_mainnet(
    name: 'Mainnet',
  ),
  valhalla_testnet(
    name: 'Valhalla',
  ),
  private_network(
    name: 'Private',
  );

  const Network({
    required this.name,
  });

  final String name;
}
