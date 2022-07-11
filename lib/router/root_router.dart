import 'package:flutter/material.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/models/transfer_details.dart';
import 'package:ribn/presentation/asset_details/asset_details_page.dart';
import 'package:ribn/presentation/enable_page.dart';
import 'package:ribn/presentation/external_signing_page.dart';
import 'package:ribn/presentation/home/home_page.dart';
import 'package:ribn/presentation/login/login_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/create_password_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/getting_started_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_confirmation_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_display_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_generating_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_info_checklist_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_instructions_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/select_action_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/wallet_info_checklist_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/welcome_page.dart';
import 'package:ribn/presentation/onboarding/extension_info_page.dart';
import 'package:ribn/presentation/onboarding/restore_wallet/create_new_wallet_password_page.dart';
import 'package:ribn/presentation/onboarding/restore_wallet/enter_wallet_password_page.dart';
import 'package:ribn/presentation/onboarding/restore_wallet/restore_wallet_page.dart';
import 'package:ribn/presentation/onboarding/restore_wallet/restore_with_topl_key_page.dart';
import 'package:ribn/presentation/settings/settings_page.dart';
import 'package:ribn/presentation/transfers/asset_transfer_input_page.dart';
import 'package:ribn/presentation/transfers/mint_input_page.dart';
import 'package:ribn/presentation/transfers/poly_transfer_input_page.dart';
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
      case Routes.seedPhraseInfoChecklist:
        {
          return pageRoute(
            const SeedPhraseInfoChecklistPage(),
            settings,
          );
        }
      case Routes.seedPhraseInstructions:
        {
          return pageRoute(const SeedPhraseInstructionsPage(), settings);
        }
      case Routes.generateSeedPhrase:
        {
          return pageRoute(const SeedPhraseGeneratingPage(), settings);
        }
      case Routes.displaySeedphrase:
        {
          return pageRoute(const SeedPhraseDisplayPage(), settings);
        }
      case Routes.seedPhraseConfirm:
        {
          return pageRoute(const SeedPhraseConfirmationPage(), settings);
        }
      case Routes.walletInfoChecklist:
        {
          return pageRoute(const WalletInfoChecklistPage(), settings);
        }
      case Routes.createPassword:
        {
          return pageRoute(const CreatePasswordPage(), settings);
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
      case Routes.assetsTransferInput:
        {
          return pageRoute(const AssetTransferInputPage(), settings);
        }
      case Routes.restoreWallet:
        {
          return pageRoute(const RestoreWalletPage(), settings);
        }
      case Routes.restoreWithToplKey:
        {
          return pageRoute(const RestoreWithToplKeyPage(), settings);
        }
      case Routes.restoreWalletNewPassword:
        {
          final String seedPhrase = settings.arguments as String;
          return pageRoute(
            NewWalletPasswordPage(
              seedPhrase: seedPhrase,
            ),
            settings,
          );
        }
      case Routes.enterWalletPassword:
        {
          final String keyStoreJson = settings.arguments as String;
          return pageRoute(
            EnterWalletPasswordPage(toplKeyStoreJson: keyStoreJson),
            settings,
          );
        }

      case Routes.polyTransferInput:
        {
          return pageRoute(const PolyTransferInputPage(), settings);
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
          return pageRoute(
            const MintInputPage(),
            settings,
          );
        }
      case Routes.assetDetails:
        {
          final Map<String, dynamic> assetDetailsPageArgs = settings.arguments as Map<String, dynamic>;
          return pageRoute(
            AssetDetailsPage(asset: assetDetailsPageArgs['assetAmount']!),
            settings,
          );
        }
      case Routes.settings:
        {
          return pageRoute(const SettingsPage(), settings);
        }
      case Routes.enable:
        {
          final InternalMessage pendingRequest = settings.arguments as InternalMessage;
          return pageRoute(EnablePage(pendingRequest), settings);
        }
      case Routes.externalSigning:
        {
          final InternalMessage pendingRequest = settings.arguments as InternalMessage;
          return pageRoute(ExternalSigningPage(pendingRequest), settings);
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
    return MaterialPageRoute(
      builder: (context) {
        return Center(
          child: Text(
            errorMsg,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        );
      },
    );
  }

  /// Builds a page route without any animation.
  Route<MaterialPageRoute> pageRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => page, settings: settings);
    //  PageRouteBuilder(
    //   settings: settings,
    //   pageBuilder: (context, animation, secondaryAnimation) => page,
    //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //     const begin = Offset(1.0, 0.0);
    //     const end = Offset.zero;
    //     final tween = Tween(begin: begin, end: end);
    //     final offsetAnimation = animation.drive(tween);
    //     return SlideTransition(
    //       position: offsetAnimation,
    //       child: child,
    //     );
    //   },
    //   transitionDuration: kIsWeb ? Duration.zero : const Duration(milliseconds: 100),
    //   reverseTransitionDuration: kIsWeb ? Duration.zero : const Duration(milliseconds: 100),
    // );
  }
}
