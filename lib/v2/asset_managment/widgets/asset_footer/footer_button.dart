// Flutter imports:
import 'package:flutter/material.dart';
import 'package:ribn/v2/onboarding/widgets/modals/send_receive_modal.dart';
import 'package:ribn/v2/shared/extensions/widget_extensions.dart';

class FooterFloatingButton extends StatelessWidget {
  const FooterFloatingButton({
    super.key,
  });
  static const welcomeButtonKey = Key('welcomePageCreateButtonKey');
  static const welcomePageImportButtonKey = Key('welcomePageImportButtonKey');
  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
      backgroundColor: Color(0XFF0DC8D4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      key: welcomeButtonKey,
      onPressed: () {
        SendReceiveModal().showAsModal(
          context,
          initialChildSize: 0.33,
        );
      },
      child: new Icon(Icons.sync_alt_outlined),
    );
  }
}
