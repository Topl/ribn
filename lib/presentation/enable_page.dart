import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/misc_actions.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';

class EnablePage extends StatelessWidget {
  final InternalMessage pendingRequest;
  const EnablePage(this.pendingRequest, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Grant permission to: ${pendingRequest.origin}',
          style: const TextStyle(
            fontSize: UIConstants.smallTextSize,
          ),
        ),
        MaterialButton(
          child: const Text('Accept'),
          onPressed: () => sendResponse(context, true),
        ),
        MaterialButton(
          child: const Text('Reject'),
          onPressed: () => sendResponse(context, false),
        ),
      ],
    );
  }

  void sendResponse(BuildContext context, bool accept) {
    final InternalMessage response = pendingRequest.copyWith(
      method: Strings.returnResponse,
      sender: InternalMessage.defaultSender,
      data: {
        'enabled': accept,
      },
    );
    StoreProvider.of<AppState>(context).dispatch(SendInternalMsgAction(response));
  }
}
