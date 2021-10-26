import 'package:flutter/material.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/presentation/address_section.dart';
import 'package:ribn/presentation/home_page.dart';
import 'package:ribn/presentation/login_page.dart';
import 'package:ribn/presentation/onboarding/extension_info_page.dart';
import 'package:ribn/presentation/onboarding/getting_started_page.dart';
import 'package:ribn/presentation/onboarding/onboarding_steps.dart';
import 'package:ribn/presentation/onboarding/read_carefully_page_one.dart';
import 'package:ribn/presentation/onboarding/select_action_page.dart';
import 'package:ribn/presentation/onboarding/welcome_page.dart';

class RootRouter {
  Route<MaterialPageRoute> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcome:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const WelcomePage(),
          );
        }
      case Routes.selectAction:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const SelectActionPage(),
          );
        }
      case Routes.gettingStarted:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const GettingStartedPage(),
          );
        }
      case Routes.readCarefully:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const ReadCarefullyPageOne(),
          );
        }
      case Routes.onboardingSteps:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const OnboardingStepsPage(),
          );
        }
      case Routes.extensionInfo:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const ExtensionInfoPage(),
          );
        }
      case Routes.login:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const LoginPage(),
          );
        }
      case Routes.home:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const HomePage(),
          );
        }
      case Routes.addresses:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => AddressSection(),
          );
        }
      case Routes.error:
        {
          String errorMessage = (settings.arguments ?? "Unknown error occurred") as String;
          return errorRoute(errorMsg: errorMessage);
        }
      default:
        return errorRoute();
    }
  }

  Route<MaterialPageRoute> errorRoute({String errorMsg = "Unknown error occurred"}) {
    return MaterialPageRoute(builder: (context) {
      return Center(
        child: Text(
          errorMsg,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      );
    });
  }
}
