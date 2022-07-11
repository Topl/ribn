import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn_toolkit/constants/assets.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/animated_circle_step_loader.dart';

/// Builds the custom animation when generating seed phrase.
class SeedPhraseGeneratingPage extends StatefulWidget {
  final VoidCallback goToNextPage;
  const SeedPhraseGeneratingPage(this.goToNextPage, {Key? key}) : super(key: key);

  @override
  State<SeedPhraseGeneratingPage> createState() => _SeedPhraseGeneratingPageState();
}

class _SeedPhraseGeneratingPageState extends State<SeedPhraseGeneratingPage> {
  bool showStepLoader = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: showStepLoader ? seedPhraseGeneratingSection() : seedPhraseGeneratedSection(),
      ),
    );
  }

  void updateShowStepLoader() {
    setState(() {
      showStepLoader = false;
    });
  }

  /// Display this section when seed phrase is generating.
  List<Widget> seedPhraseGeneratingSection() {
    return [
      AnimatedCircleStepLoader(
        showStepLoader: updateShowStepLoader,
        stepLabels: const {
          0: Strings.seedPhraseGenerating,
          1: Strings.goGrabAPenAndPaper,
          2: Strings.seriouslyGetAPenAndPaper,
          3: Strings.seedPhraseGenerating,
          4: Strings.seedPhraseGenerating,
        },
      ),
      const SizedBox(height: 70),
      const SizedBox(
        height: 100,
        width: 700,
        child: Text(Strings.aboutToShowSeedPhrase, style: RibnToolkitTextStyles.body1),
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
            style: RibnToolkitTextStyles.h1,
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
        child: Text(Strings.seedPhraseGeneratedDesc, style: RibnToolkitTextStyles.body1),
      ),
      const SizedBox(height: 30),
      LargeButton(
        buttonChild: Text(
          Strings.cont,
          style: RibnToolkitTextStyles.btnLarge.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: RibnColors.primary,
        hoverColor: RibnColors.primaryButtonHover,
        dropShadowColor: RibnColors.primaryButtonShadow,
        onPressed: widget.goToNextPage,
      ),
    ];
  }
}
