import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/internal_message_actions.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';

class EnablePage extends StatelessWidget {
  final InternalMessage pendingRequest;
  const EnablePage(this.pendingRequest, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RibnFont12TextWidget(
          text: 'Grant permission to: ${pendingRequest.origin}',
          textAlignment: TextAlign.start,
          textColor: RibnColors.primary,
          fontWeight: FontWeight.w500,
        ),
        LargeButton(
          buttonChild: const RibnFont12TextWidget(
            text: Strings.accept,
            textAlignment: TextAlign.justify,
            textColor: RibnColors.defaultText,
            fontWeight: FontWeight.normal,
          ),
          onPressed: () => sendResponse(context, true),
        ),
        LargeButton(
          buttonChild: const RibnFont12TextWidget(
            text: Strings.reject,
            textAlignment: TextAlign.justify,
            textColor: RibnColors.defaultText,
            fontWeight: FontWeight.normal,
          ),
          onPressed: () => sendResponse(context, false),
        ),
      ],
    );
  }

  void sendResponse(BuildContext context, bool accept) {
    final InternalMessage response = pendingRequest.copyWith(
      method: InternalMethods.returnResponse,
      sender: InternalMessage.defaultSender,
      data: {
        'enabled': accept,
      },
    );
    StoreProvider.of<AppState>(context)
        .dispatch(SendInternalMsgAction(response));
  }
}
