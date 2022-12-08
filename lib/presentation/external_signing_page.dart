import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/atoms/text/ribn_font12_text_widget.dart';

class ExternalSigningPage extends StatefulWidget {
  final InternalMessage request;
  const ExternalSigningPage(this.request, {Key? key}) : super(key: key);

  @override
  State<ExternalSigningPage> createState() => _ExternalSigningPageState();
}

class _ExternalSigningPageState extends State<ExternalSigningPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RibnFont12TextWidget(
            text: widget.request.method,
            textAlignment: TextAlign.justify,
            textColor: RibnColors.defaultText,
            fontWeight: FontWeight.normal,
          ),
          RibnFont12TextWidget(
            text: widget.request.data.toString(),
            textAlignment: TextAlign.justify,
            textColor: RibnColors.defaultText,
            fontWeight: FontWeight.normal,
          ),
          MaterialButton(
            color: Colors.blue,
            child: const RibnFont12TextWidget(
              text: Strings.sign,
              textAlignment: TextAlign.justify,
              textColor: RibnColors.defaultText,
              fontWeight: FontWeight.normal,
            ),
            onPressed: () {
              StoreProvider.of<AppState>(context)
                  .dispatch(SignExternalTxAction(widget.request));
            },
          ),
        ],
      ),
    );
  }
}
