import 'package:flutter/foundation.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:ribn/actions/keychain_actions.dart';
import 'package:ribn/actions/login_actions.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/actions/restore_wallet_actions.dart';
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:rxdart/rxdart.dart';

Epic<AppState> createEpicMiddleware(MiscRepository miscRepo) => combineEpics<AppState>([
      _persistenceTriggerEpic(),
      _generateInitialAddresses(),
      TypedEpic<AppState, ApiErrorAction>(_onApiError()),
      TypedEpic<AppState, PersistAppState>(_onPersistAppState(miscRepo)),
      TypedEpic<AppState, NavigateToRoute>(_onNavigateToRoute()),
      TypedEpic<AppState, LoginSuccessAction>(_onLoginSuccess()),
      TypedEpic<AppState, SuccessfullyRestoredWalletAction>(_onSuccessfullyRestoredWallet(miscRepo)),
    ]);

/// A list of all the actions that should trigger appState persistence
const List<dynamic> persistenceTriggers = [
  AddAddressAction,
  UpdateCurrentNetworkAction,
  UpdateBalancesAction,
  InitializeHDWalletAction,
  UpdateAssetDetailsAction,
];

/// If an action that exists in the list [persistenceTriggers] is received, this epic emits the [PersistAppState] action.
Epic<AppState> _persistenceTriggerEpic() => (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions
          .where((action) => (persistenceTriggers.contains(action.runtimeType)))
          .switchMap((action) => Stream.value(PersistAppState()));
    };

/// When HD Wallet is initialized, i.e. upon onboarding, wallet restoration, or successful login,
/// this epic checks if initial addresses need to be generated, i.e. if no addresses currently exist under any network,
/// and dispatches [GenerateInitialAddressesAction].
Epic<AppState> _generateInitialAddresses() => (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions.whereType<InitializeHDWalletAction>().switchMap((action) {
        final bool needsInitialAddressGeneration =
            store.state.keychainState.allNetworks.every((network) => network.addresses.isEmpty);
        if (needsInitialAddressGeneration) {
          return Stream.value(GenerateInitialAddressesAction());
        }
        return const Stream.empty();
      });
    };

/// Redirects to [Routes.error] whenever [ApiErrorAction] is received.
Stream<dynamic> Function(Stream<ApiErrorAction>, EpicStore<AppState>) _onApiError() {
  return (actions, store) {
    return actions.switchMap((action) => Stream.value(NavigateToRoute(Routes.error, arguments: action.errorMessage)));
  };
}

/// Handles [PersistAppState] action.
///
/// Persists the current [AppState] to local storage.
Stream<dynamic> Function(Stream<PersistAppState>, EpicStore<AppState>) _onPersistAppState(MiscRepository miscRepo) {
  return (actions, store) {
    return actions.whereType<PersistAppState>().switchMap(
      (action) {
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
      },
    );
  };
}

/// Handles [NavigateToRoute] by pushing [action.route] on the current navigation stack.
///
/// Only supports Web platform at this time, i.e. [kIsWeb] should be True.
Stream<dynamic> Function(Stream<NavigateToRoute>, EpicStore<AppState>) _onNavigateToRoute() {
  return (actions, store) {
    return actions.switchMap(
      (action) {
        Keys.navigatorKey.currentState!.pushNamed(action.route, arguments: action.arguments);
        return const Stream.empty();
      },
    );
  };
}

/// Handles the [LoginSuccessAction] by dispatching actions to initialize the Hd wallet and refresh balances.
///
/// Navigation to the next page is dependent on whether the app is currently interacting with a dApp, i.e.
/// there is a pending [InternalMessage] with method [InternalMethods.enable] or [InternalMethods.signTx],
/// or if the app is opened in the normal extension view, in which case it navigates to [Routes.home].
Stream<dynamic> Function(Stream<LoginSuccessAction>, EpicStore<AppState>) _onLoginSuccess() {
  return (actions, store) {
    return actions.switchMap(
      (action) {
        return Stream.fromIterable(
          [
            InitializeHDWalletAction(toplExtendedPrivateKey: action.toplExtendedPrvKeyUint8List),
            store.state.internalMessage?.method == InternalMethods.enable
                ? NavigateToRoute(Routes.enable, arguments: store.state.internalMessage!)
                : store.state.internalMessage?.method == InternalMethods.signTx
                    ? NavigateToRoute(Routes.externalSigning, arguments: store.state.internalMessage!)
                    : NavigateToRoute(Routes.home),
          ],
        );
      },
    );
  };
}

/// Handles [SuccessfullyRestoredWalletAction] by dispatching actions to reset the current app state,
/// initialize the hd wallet, and navigate to the home page.
///
/// [navigateToRoute] is selected based on whether the app is open in extension view or full page, i.e.
/// user is restoring wallet during onboarding (fullpage- iew) vs from the login page (extension view).
Stream<dynamic> Function(Stream<SuccessfullyRestoredWalletAction>, EpicStore<AppState>) _onSuccessfullyRestoredWallet(
  MiscRepository miscRepo,
) {
  return (actions, store) {
    return actions.switchMap((action) {
      final String navigateToRoute = store.state.needsOnboarding() ? Routes.extensionInfo : Routes.home;
      return Stream.fromIterable([
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
