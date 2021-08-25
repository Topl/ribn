import 'package:redux/redux.dart';
import 'package:ribn/middlewares/onboarding_middleware.dart';
import 'package:ribn/models/app_state.dart';

/// All epics and middlewares will be chained here
final List<Middleware<AppState>> appMiddleware = (createOnboardingMiddleware());
