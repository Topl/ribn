import 'package:favicon/favicon.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';

import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/molecules/animated_circle_step_loader.dart';

class LoadingDApp extends StatefulWidget {
  const LoadingDApp({Key? key}) : super(key: key);

  @override
  State<LoadingDApp> createState() => _LoadingDAppState();
}

class _LoadingDAppState extends State<LoadingDApp> {
  dynamic mockFaviconUrl;

  void getFaviconImage() async {
    final iconUrl = await FaviconFinder.getBest('https://topl.co');

    setState(() {
      mockFaviconUrl = iconUrl!.url;
    });
  }

  @override
  void initState() {
    getFaviconImage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: mockFaviconUrl == null
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(
                              color: RibnColors.vibrantGreen,
                            ),
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
                  },
                  showStepLoader: () {},
                  activeCircleColor: RibnColors.vibrantGreen,
                  inactiveCircleColor: RibnColors.transparentGrey,
                  activeCircleRadius: 4,
                  inactiveCircleRadius: 2,
                  dotPadding: 6,
                  hideTitle: true,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    8,
                    8,
                    8,
                    8,
                  ),
                  child: Container(
                    height: 34,
                    width: 34,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: RibnColors.vibrantGreen,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: RibnColors.primary,
                    ),
                  ),
                ),
                AnimatedCircleStepLoader(
                  stepLabels: const {
                    0: '',
                    1: '',
                    2: '',
                  },
                  showStepLoader: () {},
                  activeCircleColor: RibnColors.vibrantGreen,
                  inactiveCircleColor: RibnColors.transparentGrey,
                  activeCircleRadius: 4,
                  inactiveCircleRadius: 2,
                  dotPadding: 6,
                  hideTitle: true,
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
