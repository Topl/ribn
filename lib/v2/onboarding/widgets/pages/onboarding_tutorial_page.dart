import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OnboardingAppTutorialPageData {
  final String imagePath;
  final String title;
  final String description;

  OnboardingAppTutorialPageData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class OnboardingAppTutorial extends HookWidget {
  final OnboardingAppTutorialPageData page;

  OnboardingAppTutorial({required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(page.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40, right: 90, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              page.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 100),
              child: Text(
                page.description,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
