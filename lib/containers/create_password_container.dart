import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/onboarding_state.dart';

/// Example container to provide viewModel
class CreatePasswordContainer extends StatelessWidget {
  const CreatePasswordContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<OnboardingState> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnboardingState>(
      distinct: true,
      converter: (store) => store.state.onboardingState,
      builder: builder,
    );
  }
}
