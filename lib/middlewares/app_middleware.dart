import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:ribn/middlewares/epic_middleware.dart';
import 'package:ribn/middlewares/keychain_middleware.dart';
import 'package:ribn/middlewares/login_middleware.dart';
import 'package:ribn/middlewares/onboarding_middleware.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/keychain_repository.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:ribn/repositories/onboarding_repository.dart';

/// All epics and middlewares will be chained here
List<Middleware<AppState>> createAppMiddleware({
  required OnboardingRespository onboardingRepo,
  required LoginRepository loginRepo,
  required MiscRepository miscRepo,
  required KeychainRepository keychainRepo,
}) {
  return [
    ...(createOnboardingMiddleware(onboardingRepo)),
    ...(createLoginMiddleware(loginRepo)),
    ...(createKeychainMiddleware(keychainRepo)),
    EpicMiddleware<AppState>(createEpicMiddleware(miscRepo))
  ];
}
