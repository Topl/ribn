// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/actions/internal_message_actions.dart';
import 'package:ribn/models/internal_message.dart';

/// Reducer responsible for updating currently pending [InternalMessage], i.e. [AppState.internalMessage].
final internalMessageReducer = combineReducers<InternalMessage?>(
  [
    TypedReducer<InternalMessage?, ReceivedInternalMsgAction>(
        _onReceivedInternalMsg,),
  ],
);

InternalMessage _onReceivedInternalMsg(
    InternalMessage? internalMessage, ReceivedInternalMsgAction action,) {
  return action.pendingRequest;
}
