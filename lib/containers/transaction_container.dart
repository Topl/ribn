// ignore_for_file: implementation_imports

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mubrambl/src/core/amount.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/models/app_state.dart';

class TransactionContainer extends StatelessWidget {
  const TransactionContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<TransactionViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionViewModel>(
      distinct: true,
      converter: (store) => TransactionViewModel.fromStore(store),
      builder: builder,
    );
  }
}

class TransactionViewModel {
  final List<AssetAmount> assets;
  final Function(Map<String, dynamic>) initiateTx;

  const TransactionViewModel({
    required this.assets,
    required this.initiateTx,
  });

  static TransactionViewModel fromStore(Store<AppState> store) {
    return TransactionViewModel(
      assets: store.state.keychainState.currentNetwork.addresses
          .map((addr) => addr.balance.assets ?? [])
          .expand((amount) => amount)
          .toList(),
      initiateTx: (Map<String, dynamic> transferDetails) {
        store.dispatch(InitiateTxAction(transferDetails));
      },
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionViewModel &&
        listEquals(other.assets, assets) &&
        other.initiateTx == initiateTx;
  }

  @override
  int get hashCode => assets.hashCode ^ initiateTx.hashCode;
}
