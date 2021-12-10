import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';

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
      appBar: AppBar(),
      body: Column(
        children: [
          Text(widget.request.method),
          Text(widget.request.data.toString()),
          MaterialButton(
            color: Colors.blue,
            child: const Text(Strings.sign),
            onPressed: () {
              StoreProvider.of<AppState>(context).dispatch(SignExternalTxAction(widget.request));
            },
          ),
        ],
      ),
    );
  }
}
