// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:mubrambl/brambldart.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/containers/transaction_container.dart';
import 'package:mubrambl/src/core/amount.dart';

/// Builds the transaction section that is seen under one of the main tabs on the home page.
class TransactionSection extends StatefulWidget {
  const TransactionSection({Key? key}) : super(key: key);

  @override
  _TransactionSectionState createState() => _TransactionSectionState();
}

class _TransactionSectionState extends State<TransactionSection> {
  final Map<String, dynamic> _transferDetails = {
    Strings.transferType: Strings.polyTransfer,
  };

  @override
  Widget build(BuildContext context) {
    return TransactionContainer(builder: (context, vm) {
      return SingleChildScrollView(
        child: Column(
          children: [
            _buildTransferMenu(_transferDetails[Strings.transferType], Rules.transferTypes),
            _buildTransferForm(vm),
          ],
        ),
      );
    });
  }

  void _onSubmit(TransactionViewModel vm) => vm.initiateTx(_transferDetails);

  Form _buildTransferForm(TransactionViewModel vm) {
    switch (_transferDetails[Strings.transferType]) {
      case Strings.polyTransfer:
        {
          return _buildPolyTransferForm(() => _onSubmit(vm));
        }
      case Strings.assetTransfer:
        {
          return _buildAssetTransferForm(() => _onSubmit(vm), vm.assets, minting: false);
        }
      case Strings.minting:
        {
          return _buildAssetTransferForm(() => _onSubmit(vm), vm.assets, minting: true);
        }
      default:
        {
          return _buildPolyTransferForm(() => vm.initiateTx(_transferDetails));
        }
    }
  }

  /// Builds the poly transfer form.
  Form _buildPolyTransferForm(VoidCallback? onSubmit) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTextField(
            Strings.receiver,
            (val) {
              setState(() {
                _transferDetails[Strings.recipient] = val ?? "";
              });
            },
          ),
          _buildTextField(
            Strings.amount,
            (val) {
              setState(() {
                _transferDetails[Strings.amount] = val ?? "0";
              });
            },
          ),
          MaterialButton(
            child: const Text(Strings.send),
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }

  /// Builds the asset transfer form.
  /// Input fields differ depending on if an asset is being minted or
  /// an existing asset is being transfered.
  Form _buildAssetTransferForm(VoidCallback onSubmit, List<AssetAmount> assets, {bool minting = false}) {
    return Form(
      child: (!minting && assets.isEmpty)
          ? const Text(Strings.noAssets)
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTextField(
                  minting ? Strings.assetName : Strings.receiver,
                  (val) {
                    setState(() {
                      _transferDetails[minting ? Strings.assetName : Strings.recipient] = val;
                    });
                  },
                ),
                minting ? const SizedBox() : _buildAssetMenu(_transferDetails[Strings.asset], assets),
                _buildTextField(
                  Strings.amount,
                  (val) {
                    setState(() {
                      _transferDetails[Strings.amount] = val ?? "0";
                    });
                  },
                ),
                MaterialButton(
                  child: Text(minting ? Strings.mint : Strings.send),
                  onPressed: onSubmit,
                ),
              ],
            ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: UIConstants.generalPadding),
      child: Column(
        children: [
          SizedBox(
            width: UIConstants.textFieldSize,
            child: TextFormField(
              onChanged: onChanged,
              decoration: InputDecoration(
                labelText: label,
                isDense: true,
                contentPadding: const EdgeInsets.all(UIConstants.generalPadding),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferMenu(
    String dropdownValue,
    List<String> transferTypes,
  ) {
    return DropdownButton<String>(
      value: dropdownValue,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? transferType) {
        setState(() {
          _transferDetails[Strings.transferType] = transferType ?? Strings.polyTransfer;
        });
      },
      items: transferTypes.map<DropdownMenuItem<String>>((String transferType) {
        return DropdownMenuItem<String>(
          value: transferType,
          child: Text(transferType),
        );
      }).toList(),
    );
  }

  Widget _buildAssetMenu(
    AssetAmount currAsset,
    List<AssetAmount> assets,
  ) {
    return DropdownButton<AssetAmount>(
      value: currAsset,
      style: const TextStyle(color: Colors.black),
      onChanged: (AssetAmount? selectedAsset) {
        setState(() {
          _transferDetails[Strings.asset] = selectedAsset;
        });
      },
      items: assets.map<DropdownMenuItem<AssetAmount>>((AssetAmount asset) {
        return DropdownMenuItem<AssetAmount>(
          value: asset,
          child: Text(asset.assetCode.shortName.show),
        );
      }).toList(),
    );
  }
}
