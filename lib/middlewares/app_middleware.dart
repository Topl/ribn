import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:ribn/middlewares/epic_middleware.dart';
import 'package:ribn/middlewares/keychain_middleware.dart';
import 'package:ribn/middlewares/login_middleware.dart';
import 'package:ribn/middlewares/onboarding_middleware.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:ribn/repositories/onboarding_repository.dart';

final OnboardingRespository _onboardingRespository = OnboardingRespository();
final MiscRepository _miscRepository = MiscRepository();
final LoginRepository _loginRepository = LoginRepository();

/// All epics and middlewares will be chained here
final List<Middleware<AppState>> appMiddleware = [
  ...(createOnboardingMiddleware(_onboardingRespository)),
  ...(createLoginMiddleware(_loginRepository)),
  ...(createKeychainMiddleware()),
  EpicMiddleware<AppState>(createEpicMiddleware(_miscRepository))
];
