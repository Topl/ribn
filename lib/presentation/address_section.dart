import 'package:flutter/material.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/containers/address_container.dart';
import 'package:ribn/models/ribn_address.dart';

class AddressSection extends StatelessWidget {
  AddressSection({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return AddressesContainer(
      builder: (context, vm) {
        return Column(
          children: [
            _buildGenerateAddressButton(vm),
            _buildAddressList(vm.addresses),
          ],
        );
      },
    );
  }

  Widget _buildGenerateAddressButton(AddressesViewModel vm) {
    return Padding(
      padding: const EdgeInsets.all(UIConstants.generalPadding),
      child: MaterialButton(
        color: Colors.blueAccent,
        child: const Text(
          Strings.generateNewAddress,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => vm.generateNewAddress(),
      ),
    );
  }

  Widget _buildAddressList(List<RibnAddress> addresses) {
    return addresses.isEmpty
        ? const Center(child: Text(Strings.noAddresses))
        : Expanded(
            child: Scrollbar(
              controller: _scrollController,
              isAlwaysShown: true,
              child: ListView.builder(
                physics: const ScrollPhysics(),
                controller: _scrollController,
                itemExtent: UIConstants.addressListTileSize,
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      addresses[index].address.toBase58(),
                      style: const TextStyle(fontSize: UIConstants.smallTextSize),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Column(
                                children: [
                                  Text(addresses[index].keyPath),
                                  Text(addresses[index].balance.polys.toString()),
                                  Text(addresses[index].balance.assets.toString()),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.more_horiz),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
