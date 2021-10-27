import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/models/app_state.dart';

class CreatePasswordContainer extends StatelessWidget {
  const CreatePasswordContainer({Key? key, required this.builder, required this.onDidChange}) : super(key: key);
  final ViewModelBuilder<CreatePasswordViewModel> builder;
  final Function(CreatePasswordViewModel?, CreatePasswordViewModel)? onDidChange;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreatePasswordViewModel>(
      distinct: true,
      converter: CreatePasswordViewModel.fromStore,
      builder: builder,
      onDidChange: onDidChange,
    );
  }
}

class CreatePasswordViewModel {
  final Function(String) attemptCreatePassword;
  final bool passwordSuccessfullyCreated;

  CreatePasswordViewModel({
    required this.attemptCreatePassword,
    this.passwordSuccessfullyCreated = false,
  });
  static CreatePasswordViewModel fromStore(Store<AppState> store) {
    return CreatePasswordViewModel(
      attemptCreatePassword: (String password) => store.dispatch(CreatePasswordAction(password)),
      passwordSuccessfullyCreated: store.state.keychainState.keyStoreJson != null,
    );
  }
}
