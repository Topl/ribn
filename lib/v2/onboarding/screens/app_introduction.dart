import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/asset_managment/screens/asset_managment_screen.dart';
import 'package:ribn/v2/onboarding/widgets/pages/onboarding_tutorial_page.dart';
import 'package:ribn/v2/shared/extensions/screen_hook_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vrouter/vrouter.dart';

class AppTutorialScreen extends ScreenConsumerWidget {
  AppTutorialScreen({Key? key}) : super(key: key, route: '/app-tutorial');
  static const appTutorial = Key('appTutorialKey');
  final PageController _controller = PageController();

//TODO: Add content to the tutorial pages from provider or from a json file
  final List<OnboardingAppTutorialPageData> pages = [
    OnboardingAppTutorialPageData(
      imagePath: 'assets/v2/icons/app-tutorial-backdrop.png',
      title: 'Learn about Topl and other terms',
      description: 'A brief excursion into the world of web 3.0',
    ),
    OnboardingAppTutorialPageData(
      imagePath: 'assets/v2/icons/app-tutorial-backdrop.png',
      title: 'Second Screen Walk through',
      description: 'This is the second walk-through page',
    ),
    OnboardingAppTutorialPageData(
      imagePath: 'assets/v2/icons/app-tutorial-backdrop.png',
      title: 'Third Walk-through page',
      description: 'This is the third walk-through page',
    ),
    OnboardingAppTutorialPageData(
      imagePath: 'assets/v2/icons/app-tutorial-backdrop.png',
      title: 'This is the last Tutorial Page',
      description: 'This is the last walk-through',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: pages.map((page) => OnboardingAppTutorial(page: page)).toList(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: pages.length,
                    effect: WormEffect(
                      dotWidth: MediaQuery.of(context).size.width * 0.2, // Adjust the value as needed
                      dotHeight: 3,
                      spacing: MediaQuery.of(context).size.width * 0.01, // Adjust the value as needed
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.grey),
                          onPressed: () {
                            _controller.previousPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.grey),
                          onPressed: () {
                            final currentPage = _controller.page ?? 0;
                            if (currentPage < pages.length - 1) {
                              _controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              );
                            } else {
                              context.vRouter.to(AssetManagementScreen().route);
                            }
                          },
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.grey,
                              ),
                              onPressed: () => context.vRouter.to(AssetManagementScreen().route),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
