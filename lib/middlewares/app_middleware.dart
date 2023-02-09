// Package imports:
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

// Project imports:
import 'package:ribn/middlewares/epic_middleware.dart';
import 'package:ribn/middlewares/internal_message_middleware.dart';
import 'package:ribn/middlewares/keychain_middleware.dart';
import 'package:ribn/middlewares/login_middleware.dart';
import 'package:ribn/middlewares/misc_middleware.dart';
import 'package:ribn/middlewares/transaction_middleware.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/keychain_repository.dart';
import 'package:ribn/repositories/login_repository.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:ribn/repositories/onboarding_repository.dart';
import 'package:ribn/repositories/transaction_repository.dart';

/// All epics and middlewares will be chained here
List<Middleware<AppState>> createAppMiddleware({
  required OnboardingRespository onboardingRepo,
  required LoginRepository loginRepo,
  required MiscRepository miscRepo,
  required KeychainRepository keychainRepo,
  required TransactionRepository transactionRepo,
}) {
  return [
    // ...(createOnboardingMiddleware(onboardingRepo)),
    ...(createLoginMiddleware(loginRepo)),
    ...(createKeychainMiddleware(keychainRepo)),
    ...(createTransactionMiddleware(transactionRepo, keychainRepo)),
    ...(createInternalMessageMiddleware(miscRepo)),
    ...(createMiscMiddleware(loginRepo, miscRepo)),
    EpicMiddleware<AppState>(createEpicMiddleware(miscRepo))
  ];
}
