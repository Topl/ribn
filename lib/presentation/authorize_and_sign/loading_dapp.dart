import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/molecules/animated_circle_step_loader.dart';

class LoadingDApp extends StatelessWidget {
  const LoadingDApp({Key? key}) : super(key: key);

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
