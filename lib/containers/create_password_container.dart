import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/models/app_state.dart';

class CreatePasswordContainer extends StatelessWidget {
  const CreatePasswordContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<CreatePasswordViewModel> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreatePasswordViewModel>(
      distinct: true,
      converter: (store) => CreatePasswordViewModel.fromStore(store),
      builder: builder,
    );
  }
}

class CreatePasswordViewModel {
  final Function attemptCreatePassword;
  final bool passwordMismatchError;
  final bool passwordTooShortError;
  final bool loadingPasswordValidation;

  CreatePasswordViewModel({
    required this.attemptCreatePassword,
    this.passwordMismatchError = false,
    this.passwordTooShortError = false,
    this.loadingPasswordValidation = false,
  });
  static CreatePasswordViewModel fromStore(Store<AppState> store) {
    return CreatePasswordViewModel(
      attemptCreatePassword: (password, confirmPassword) => store.dispatch(
        CreatePasswordAction(password, confirmPassword),
      ),
      passwordMismatchError: store.state.onboardingState.passwordMismatchError,
      passwordTooShortError: store.state.onboardingState.passwordTooShortError,
      loadingPasswordValidation: store.state.onboardingState.loadingPasswordValidation,
    );
  }
}
