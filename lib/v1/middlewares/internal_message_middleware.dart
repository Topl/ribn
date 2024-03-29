// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/v1/actions/internal_message_actions.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/repositories/misc_repository.dart';

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
