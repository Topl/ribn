import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/widgets/continue_button.dart';

/// Builds the custom animation when generating seed phrase.
class SeedPhraseGeneratingPage extends StatefulWidget {
  final VoidCallback goToNextPage;
  const SeedPhraseGeneratingPage(this.goToNextPage, {Key? key}) : super(key: key);

  @override
  State<SeedPhraseGeneratingPage> createState() => _SeedPhraseGeneratingPageState();
}

class _SeedPhraseGeneratingPageState extends State<SeedPhraseGeneratingPage> {
  late final Timer timer;
  final int numCircles = 5;
  final double smallRadius = 8;
  final double bigRadius = 16;
  int currCircle = 0;
  final Duration duration = const Duration(seconds: 2);
  final List<int> circlePositions = List.generate(5, (idx) => idx).toList();
  bool seedPhraseGenerating = true;

  @override
  void initState() {
    timer = Timer.periodic(duration, (timer) {
      if (timer.tick == numCircles) {
        seedPhraseGenerating = false;
        timer.cancel();
      }
      currCircle = (currCircle + 1) % numCircles;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: seedPhraseGenerating ? seedPhraseGeneratingSection() : seedPhraseGeneratedSection(),
        ),
      ),
    );
  }

  /// Display this section when seed phrase is generating.
  List<Widget> seedPhraseGeneratingSection() {
    return [
      SizedBox(
        height: 101,
        width: 312,
        child: _buildTitle(currCircle),
      ),
      const SizedBox(height: 70),
      SizedBox(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: circlePositions.map(_buildAnimatedContainer).toList(),
        ),
      ),
      const SizedBox(height: 70),
      const SizedBox(
        height: 100,
        width: 700,
        child: Text(Strings.aboutToShowSeedPhrase, style: RibnTextStyles.body1),
      ),
    ];
  }

  /// Display this section when seed phrase is generated.
  List<Widget> seedPhraseGeneratedSection() {
    return [
      const Center(
        child: SizedBox(
          height: 101,
          width: 312,
          child: Text(
            Strings.seedPhraseGenerated,
            style: RibnTextStyles.h1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 55.0),
        child: SvgPicture.asset(RibnAssets.seedPhraseGenerated),
      ),
      const SizedBox(
        height: 100,
        width: 715,
        child: Text(Strings.seedPhraseGeneratedDesc, style: RibnTextStyles.body1),
      ),
      const SizedBox(height: 30),
      ContinueButton(Strings.cont, widget.goToNextPage),
    ];
  }

  Widget _buildTitle(int position) {
    switch (position) {
      case 0:
      case 3:
      case 4:
        {
          return const Text(
            Strings.seedPhraseGenerating,
            style: RibnTextStyles.h1,
            textAlign: TextAlign.center,
          );
        }
      case 1:
        {
          return const Text(
            Strings.goGrabAPenAndPaper,
            style: RibnTextStyles.h1,
            textAlign: TextAlign.center,
          );
        }
      case 2:
        {
          return const Text(
            Strings.seriouslyGetAPenAndPaper,
            style: RibnTextStyles.h1,
            textAlign: TextAlign.center,
          );
        }
    }
    return const Text('');
  }

  /// Animate color and radius of the active circles.
  Widget _buildAnimatedContainer(int position) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AnimatedContainer(
        duration: duration,
        child: CircleAvatar(
          backgroundColor: position <= currCircle ? RibnColors.primary : RibnColors.inactive,
          radius: currCircle == position ? bigRadius : smallRadius,
        ),
      ),
    );
  }
}
