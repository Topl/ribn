import 'package:flutter/foundation.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:ribn/actions/internal_message_actions.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/actions/onboarding_actions.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:rxdart/rxdart.dart';

Epic<AppState> createEpicMiddleware(MiscRepository miscRepo) => combineEpics<AppState>([
      _persistorEpic(miscRepo),
      _routerEpic(),
      _errorRedirectEpic(),
      _persistenceTriggerEpic(),
      _sendToBackground(miscRepo),
      _downloadAsFile(miscRepo),
      _deleteWallet(miscRepo),
      _generateInitialAddresses(),
      TypedEpic<AppState, SuccessfullyRestoredWalletAction>(_onSuccessfullyRestoredWallet(miscRepo)),
    ]);

/// A list of all the actions that should trigger appState persistence
const List<dynamic> persistenceTriggers = [
  AddAddressesAction,
  UpdateBalancesAction,
  InitializeHDWalletAction,
  MnemonicSuccessfullyVerifiedAction,
  UpdateAssetDetailsAction,
];

/// Persists the latest [AppState] whenever [PersistAppState] action is emitted
Epic<AppState> _persistorEpic(MiscRepository miscRepo) => (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions.whereType<PersistAppState>().switchMap((action) {
        Future<dynamic> persistAppState() async {
          try {
            // state is not persisted when app opened in debug view
            if (!await miscRepo.isAppOpenedInDebugView()) {
              await miscRepo.persistAppState(store.state.toJson());
            }
          } catch (e) {
            return ApiErrorAction('Failed to persist state. Error: ${e.toString()}');
          }
        }

        return Stream.fromFuture(persistAppState());
      });
    };

/// Platform conditional navigator to avoid a null navigator during tests.
/// Support for other platforms will be added in the future.
Epic<AppState> _routerEpic() => (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions.whereType<NavigateToRoute>().switchMap(
        (action) {
          if (kIsWeb) {
            Keys.navigatorKey.currentState!.pushNamed(action.route, arguments: action.arguments);
          }
          return const Stream.empty();
        },
      );
    };

/// Swallows action and redirects to error page whenever [ApiErrorAction] is emitted
/// Currently only for dev purposes
/// @TODO: Replace with user-friendly error-handling in the future
Epic<AppState> _errorRedirectEpic() => (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions.whereType<ApiErrorAction>().switchMap(
        (action) {
          return Stream.value(NavigateToRoute(Routes.error, arguments: action.errorMessage));
        },
      );
    };

/// If an action that exists in the list [persistenceTriggers] is received, this epic emits the [PersistAppState] action.
Epic<AppState> _persistenceTriggerEpic() => (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions
          .where((action) => (persistenceTriggers.contains(action.runtimeType)))
          .switchMap((action) => Stream.value(PersistAppState()));
    };

/// Listens for [SendInternalMsgAction] - message to be sent to the background-script
Epic<AppState> _sendToBackground(MiscRepository miscRepo) => (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions.whereType<SendInternalMsgAction>().switchMap((action) {
        miscRepo.sendInternalMessage(action.msg);
        return const Stream.empty();
      });
    };

/// Listens for [DownloadAsFile] and downloads the text data as a file.
Epic<AppState> _downloadAsFile(MiscRepository miscRepo) => (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions.whereType<DownloadAsFile>().switchMap((action) {
        miscRepo.downloadAsFile(action.fileName, action.text);
        return const Stream.empty();
      });
    };

/// Listens for [DeleteWalletAction] and downloads the text data as a file.
Epic<AppState> _deleteWallet(MiscRepository miscRepo) => (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions.whereType<DeleteWalletAction>().switchMap((action) {
        miscRepo.deleteWallet();
        return const Stream.empty();
      });
    };

Epic<AppState> _generateInitialAddresses() => (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions.whereType<InitializeHDWalletAction>().switchMap(
            (action) => Stream.value(
              GenerateInitialAddressesAction(store.state.keychainState.hdWallet),
            ),
          );
    };

/// Handles [SuccessfullyRestoredWalletAction] by dispatching actions to reset the current app state,
/// initialize the hd wallet, and navigate to the home page.
///
/// [navigateToRoute] is selected based on whether the app is open in extension view or full page, i.e.
/// user is restoring wallet during onboarding (fullpage- iew) vs from the login page (extension view).
Stream<dynamic> Function(Stream<SuccessfullyRestoredWalletAction>, EpicStore<AppState>) _onSuccessfullyRestoredWallet(
  MiscRepository miscRepo,
) {
  return (actions, store) {
    return actions.switchMap((action) async* {
      final String navigateToRoute = await miscRepo.isAppOpenedInExtensionView() ? Routes.home : Routes.extensionInfo;
      yield* Stream.fromIterable([
        const ResetAppStateAction(),
        InitializeHDWalletAction(
          keyStoreJson: action.keyStoreJson,
          toplExtendedPrivateKey: action.toplExtendedPrivateKey,
        ),
        NavigateToRoute(navigateToRoute),
      ]);
    });
  };
}
