// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';

// // Project imports:
// import 'package:ribn/actions/onboarding_actions.dart';
// import 'package:ribn/models/app_state.dart';

// class CreatePasswordContainer extends StatelessWidget {
//   const CreatePasswordContainer({
//     Key? key,
//     required this.builder,
//     required this.onDidChange,
//   }) : super(key: key);
//   final ViewModelBuilder<CreatePasswordViewModel> builder;
//   final Function(CreatePasswordViewModel?, CreatePasswordViewModel)?
//       onDidChange;

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, CreatePasswordViewModel>(
//       distinct: true,
//       converter: CreatePasswordViewModel.fromStore,
//       builder: builder,
//       onDidChange: onDidChange,
//     );
//   }
// }

// class CreatePasswordViewModel {
//   final Function(String) attemptCreatePassword;
//   final bool passwordSuccessfullyCreated;
//   final String? keyStoreJson;

//   CreatePasswordViewModel({
//     required this.attemptCreatePassword,
//     this.passwordSuccessfullyCreated = false,
//     required this.keyStoreJson,
//   });
//   static CreatePasswordViewModel fromStore(Store<AppState> store) {
//     return CreatePasswordViewModel(
//       attemptCreatePassword: (String password) =>
//           store.dispatch(CreatePasswordAction(password)),
//       passwordSuccessfullyCreated:
//           store.state.keychainState.keyStoreJson != null,
//       keyStoreJson: store.state.keychainState.keyStoreJson,
//     );
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is CreatePasswordViewModel &&
//         other.passwordSuccessfullyCreated == passwordSuccessfullyCreated &&
//         other.keyStoreJson == keyStoreJson;
//   }

//   @override
//   int get hashCode =>
//       passwordSuccessfullyCreated.hashCode & keyStoreJson.hashCode;
// }
