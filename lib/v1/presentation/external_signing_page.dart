// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:ribn/v1/actions/transaction_actions.dart';
import 'package:ribn/v1/constants/strings.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/models/internal_message.dart';

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
          Text(widget.request.id),
          Text(widget.request.method),
          Text(widget.request.origin),
          Text(widget.request.sender),
          Text(widget.request.target),
          Text(widget.request.data.toString()),
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
