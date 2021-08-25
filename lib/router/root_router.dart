import 'package:flutter/material.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/presentation/create_password_page.dart';
import 'package:ribn/presentation/home_page.dart';
import 'package:ribn/presentation/login_page.dart';
import 'package:ribn/presentation/seed_phrase_confirmation_page.dart';
import 'package:ribn/presentation/seed_phrase_page.dart';
import 'package:ribn/presentation/select_action_page.dart';
import 'package:ribn/presentation/welcome_page.dart';

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
      case Routes.createPassword:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const CreatePasswordPage(),
          );
        }
      case Routes.seedPhrase:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const SeedPhrasePage(),
          );
        }
      case Routes.seedPhraseConfirm:
        {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const SeedPhraseConfirmationPage(),
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
            builder: (context) => const HomePage(title: "Ribn"),
          );
        }
      default:
        return errorRoute();
    }
  }

  Route<MaterialPageRoute> errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Text("Invalid Route");
    });
  }
}
