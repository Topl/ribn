import 'package:redux/redux.dart';
import 'package:ribn/actions/internal_message_actions.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/repositories/misc_repository.dart';

List<Middleware<AppState>> createInternalMessageMiddleware(
  MiscRepository miscRepo,
) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, SendInternalMsgAction>(
      _onSendInternalMsg(miscRepo),
    ),
  ];
}

void Function(
  Store<AppState> store,
  SendInternalMsgAction action,
  NextDispatcher next,
) _onSendInternalMsg(
  MiscRepository miscRepo,
) {
  return (store, action, next) => miscRepo.sendInternalMessage(action.msg);
}
