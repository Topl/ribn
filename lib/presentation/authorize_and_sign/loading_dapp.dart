// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
// Project imports:
import 'package:ribn/actions/transaction_actions.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/molecules/animated_circle_step_loader.dart';

class LoadingDApp extends StatefulWidget {
  const LoadingDApp({Key? key, required this.response}) : super(key: key);

  final InternalMessage response;

  @override
  State<LoadingDApp> createState() => _LoadingDAppState();
}

class _LoadingDAppState extends State<LoadingDApp> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      StoreProvider.of<AppState>(context)
          .dispatch(SignExternalTxAction(widget.response));
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    const String mockFaviconUrl = '';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[RibnColors.tertiary, RibnColors.primaryOffColor],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              Strings.connecting,
              style: TextStyle(
                height: 2,
                fontFamily: 'DM Sans',
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    8,
                    8,
                    8,
                    8,
                  ),
                  child: Container(
                    height: 61,
                    width: 61,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: RibnColors.transparentGrey,
                    ),
                    child: mockFaviconUrl == ''
                        ? Image.asset(
                            RibnAssets.undefinedIcon,
                            width: 25,
                          )
                        : Image.network(
                            mockFaviconUrl,
                            width: 25,
                          ),
                  ),
                ),
                AnimatedCircleStepLoader(
                  stepLabels: const {
                    0: '',
                    1: '',
                    2: '',
                    3: '',
                    4: '',
                    5: '',
                  },
                  showStepLoader: () {},
                  activeCircleColor: RibnColors.vibrantGreen,
                  inactiveCircleColor: RibnColors.transparentGrey,
                  activeCircleRadius: 4,
                  inactiveCircleRadius: 2,
                  dotPadding: 6,
                  hideTitle: true,
                  renderCenterIcon: true,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    8,
                    8,
                    8,
                    8,
                  ),
                  child: SizedBox(
                    height: 61,
                    width: 61,
                    child: Image.asset(RibnAssets.newCircleRibnLogo),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
