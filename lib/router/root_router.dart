import 'package:brambldart/model.dart';
import 'package:flutter/material.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/transfer_details.dart';
import 'package:ribn/presentation/address_section.dart';
import 'package:ribn/presentation/home_page.dart';
import 'package:ribn/presentation/login_page.dart';
import 'package:ribn/presentation/onboarding/extension_info_page.dart';
import 'package:ribn/presentation/onboarding/getting_started_page.dart';
import 'package:ribn/presentation/onboarding/onboarding_steps.dart';
import 'package:ribn/presentation/onboarding/read_carefully_page_one.dart';
import 'package:ribn/presentation/onboarding/select_action_page.dart';
import 'package:ribn/presentation/onboarding/welcome_page.dart';
import 'package:ribn/presentation/settings_page.dart';
import 'package:ribn/presentation/transfers/asset_transfer_input_page.dart';
import 'package:ribn/presentation/transfers/mint_input_page.dart';
import 'package:ribn/presentation/transfers/tx_confirmation_page.dart';
import 'package:ribn/presentation/transfers/tx_review_page.dart';

class RootRouter {
  Route<MaterialPageRoute> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcome:
        {
          return pageRoute(const WelcomePage(), settings);
        }
      case Routes.selectAction:
        {
          return pageRoute(const SelectActionPage(), settings);
        }
      case Routes.gettingStarted:
        {
          return pageRoute(const GettingStartedPage(), settings);
        }
      case Routes.readCarefully:
        {
          return pageRoute(const ReadCarefullyPageOne(), settings);
        }
      case Routes.onboardingSteps:
        {
          return pageRoute(const OnboardingStepsPage(), settings);
        }
      case Routes.extensionInfo:
        {
          return pageRoute(const ExtensionInfoPage(), settings);
        }
      case Routes.login:
        {
          return pageRoute(const LoginPage(), settings);
        }
      case Routes.home:
        {
          return pageRoute(const HomePage(), settings);
        }
      case Routes.assetTransferInput:
        {
          final AssetAmount asset = settings.arguments as AssetAmount;
          return pageRoute(AssetTransferInputPage(asset: asset), settings);
        }
      case Routes.txReview:
        {
          final TransferDetails transferDetails = settings.arguments as TransferDetails;
          return pageRoute(TxReviewPage(transferDetails: transferDetails), settings);
        }
      case Routes.txConfirmation:
        {
          final TransferDetails transferDetails = settings.arguments as TransferDetails;
          return pageRoute(TxConfirmationPage(transferDetails: transferDetails), settings);
        }
      case Routes.mintInput:
        {
          return pageRoute(const MintInputPage(), settings);
        }
      case Routes.addresses:
        {
          return pageRoute(AddressSection(), settings);
        }
      case Routes.settings:
        {
          return pageRoute(const SettingsPage(), settings);
        }
      case Routes.error:
        {
          final String errorMessage = (settings.arguments ?? 'Unknown error occurred') as String;
          return errorRoute(errorMsg: errorMessage);
        }
      default:
        return errorRoute();
    }
  }

  Route<MaterialPageRoute> errorRoute({String errorMsg = 'Unknown error occurred'}) {
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

  /// Builds a page route without any animation.
  Route<MaterialPageRoute> pageRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
