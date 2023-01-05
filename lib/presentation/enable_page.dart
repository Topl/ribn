import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/internal_message_actions.dart';
import 'package:ribn/constants/ui_constants.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';

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
        LargeButton(
          buttonChild: const Text('Accept'),
          onPressed: () => sendResponse(context, true),
        ),
        LargeButton(
          buttonChild: const Text('Reject'),
          onPressed: () => sendResponse(context, false),
        ),
      ],
    );
  }

  void sendResponse(BuildContext context, bool accept) {
    late final InternalMessage response;

    if (!accept) {
      response = pendingRequest.copyWith(
        method: InternalMethods.returnResponse,
        sender: InternalMessage.defaultSender,
        data: {
          'enabled': accept,
        },
      );
    } else {
      response = pendingRequest.copyWith(
        method: InternalMethods.returnResponse,
        sender: InternalMessage.defaultSender,
        data: {
          'enabled': accept,
          'walletAddress': StoreProvider.of<AppState>(context)
              .state
              .keychainState
              .currentNetwork
              .addresses
              .first
              .toplAddress
              .toBase58()
        },
      );
    }
    StoreProvider.of<AppState>(context)
        .dispatch(SendInternalMsgAction(response));
  }
}
