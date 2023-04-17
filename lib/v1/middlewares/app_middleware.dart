// Package imports:
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

// Project imports:
import 'package:ribn/v1/middlewares/epic_middleware.dart';
import 'package:ribn/v1/middlewares/internal_message_middleware.dart';
import 'package:ribn/v1/middlewares/keychain_middleware.dart';
import 'package:ribn/v1/middlewares/transaction_middleware.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/repositories/keychain_repository.dart';
import 'package:ribn/v1/repositories/misc_repository.dart';
import 'package:ribn/v1/repositories/onboarding_repository.dart';
import 'package:ribn/v1/repositories/transaction_repository.dart';

/// All epics and middlewares will be chained here
List<Middleware<AppState>> createAppMiddleware({
  required OnboardingRespository onboardingRepo,
  required MiscRepository miscRepo,
  required KeychainRepository keychainRepo,
  required TransactionRepository transactionRepo,
}) {
  return [
    ...(createKeychainMiddleware(keychainRepo)),
    ...(createTransactionMiddleware(transactionRepo, keychainRepo)),
    ...(createInternalMessageMiddleware(miscRepo)),
    EpicMiddleware<AppState>(createEpicMiddleware(miscRepo))
  ];
}
