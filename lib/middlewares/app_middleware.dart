import 'package:bip_topl/bip_topl.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:ribn/middlewares/epic_middleware.dart';
import 'package:ribn/middlewares/onboarding_middleware.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:ribn/repositories/onboarding_repository.dart';

final Cip1852KeyTree _cip1852keyTree = Cip1852KeyTree();
final OnboardingRespository _onboardingRespository = OnboardingRespository(
  cip1852keyTree: _cip1852keyTree,
);
final MiscRepository _miscRepository = MiscRepository();

/// All epics and middlewares will be chained here
final List<Middleware<AppState>> appMiddleware = [
  ...(createOnboardingMiddleware(_onboardingRespository)),
  EpicMiddleware<AppState>(createEpicMiddleware(_miscRepository))
];
