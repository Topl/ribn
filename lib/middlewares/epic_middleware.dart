import 'package:redux_epics/redux_epics.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/misc_repository.dart';
import 'package:rxdart/rxdart.dart';

Epic<AppState> createEpicMiddleware(MiscRepository miscRepo) => combineEpics<AppState>([
      _persistorEpic(miscRepo),
    ]);

/// Persists the latest [AppState] whenever [PersistAppState] action is emitted
Epic<AppState> _persistorEpic(MiscRepository miscRepo) =>
    (Stream<dynamic> actions, EpicStore<AppState> store) {
      return actions.whereType<PersistAppState>().switchMap((action) {
        Future<dynamic> persistAppState() async {
          try {
            await miscRepo.persistAppState(store.state.toJson());
          } catch (e) {
            return FailedToPersistAppStateAction();
          }
        }

        return Stream.fromFuture(persistAppState());
      });
    };
