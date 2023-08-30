// Flutter imports:
import 'package:flutter/material.dart';

class FooterFloatingButton extends StatelessWidget {
  const FooterFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
      backgroundColor: Color(0XFF0DC8D4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      onPressed: () {
        // TODO SDK: Implement show send and receive screens
      },
      child: new Icon(Icons.sync_alt_outlined),
    );
  }
}
