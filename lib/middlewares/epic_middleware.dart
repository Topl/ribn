import 'package:redux_epics/redux_epics.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:rxdart/rxdart.dart';

Epic<AppState> createEpicMiddleware(MiscRepository miscRepo) => combineEpics<AppState>([
      _persistorEpic(miscRepo),
      _errorRedirectEpic(),
    ]);

/// Persists the latest [AppState] whenever [PersistAppState] action is emitted
Epic<AppState> _persistorEpic(MiscRepository miscRepo) =>
    (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions.whereType<PersistAppState>().switchMap((action) {
        Future<dynamic> persistAppState() async {
          try {
            await miscRepo.persistAppState(store.state.toJson());
          } catch (e) {
            return ApiErrorAction(e.toString());
          }
        }

        return Stream.fromFuture(persistAppState());
      });
    };

/// Swallows action and redirects to error page whenever [ApiErrorAction] is emitted
/// Currently only for dev purposes
/// @TODO: Replace with user-friendly error-handling in the future
Epic<AppState> _errorRedirectEpic() => (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions.whereType<ApiErrorAction>().switchMap((action) {
        Keys.navigatorKey.currentState!.pushNamed(Routes.error, arguments: action.errorMessage);
        return const Stream.empty();
      });
    };
