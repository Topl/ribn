import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/widgets/molecules/animated_circle_step_loader.dart';
import 'package:ribn_toolkit/widgets/molecules/wave_container.dart';

class LoadingDApp extends StatelessWidget {
  const LoadingDApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaveContainer(
        containerChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
