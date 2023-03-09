// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:ribn_toolkit/models/transactions/ribn_activity_details_model.dart';

// Project imports:
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/models/transfer_details.dart';
import 'package:ribn/presentation/asset_details/asset_details_page.dart';
import 'package:ribn/presentation/authorize_and_sign/connect_dapp.dart';
import 'package:ribn/presentation/authorize_and_sign/loading_dapp.dart';
import 'package:ribn/presentation/authorize_and_sign/review_and_sign.dart';
import 'package:ribn/presentation/enable_page.dart';
import 'package:ribn/presentation/external_signing_page.dart';
import 'package:ribn/presentation/home/home_page.dart';
import 'package:ribn/presentation/login/login_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/create_password_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/enable_biometrics_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/getting_started_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_confirmation_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_display_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_generating_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_info_checklist_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/seed_phrase_instructions_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/select_action_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/wallet_created_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/wallet_info_checklist_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/welcome_page.dart';
import 'package:ribn/presentation/onboarding/extension_info_page.dart';
import 'package:ribn/presentation/onboarding/restore_wallet/create_new_wallet_password_page.dart';
import 'package:ribn/presentation/onboarding/restore_wallet/enter_wallet_password_page.dart';
import 'package:ribn/presentation/onboarding/restore_wallet/restore_wallet_page.dart';
import 'package:ribn/presentation/onboarding/restore_wallet/restore_with_topl_key_page.dart';
import 'package:ribn/presentation/onboarding/widgets/opt_in_tracker_page.dart';
import 'package:ribn/presentation/settings/settings_page.dart';
import 'package:ribn/presentation/transaction_history/transaction_history_details_page/transaction_history_details_page.dart';
import 'package:ribn/presentation/transaction_history/transaction_history_page.dart';
import 'package:ribn/presentation/transfers/asset_transfer_page.dart';
import 'package:ribn/presentation/transfers/mint_input_page.dart';
import 'package:ribn/presentation/transfers/tx_confirmation_page.dart';
import 'package:ribn/presentation/transfers/tx_review_page.dart';

// import 'package:ribn/models/transaction_history_entry.dart';

// import 'package:ribn/models/transaction_history_entry.dart';

class RootRouter {
  Route<MaterialPageRoute> generateRoutes(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case Routes.welcome:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const WelcomePage(), settings);
          }
          return pageRoute(const WelcomePage(), settings);
        }
      case Routes.optIn:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const OptInTracker(), settings);
          }
          return pageRoute(const OptInTracker(), settings);
        }
      case Routes.selectAction:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const SelectActionPage(), settings);
          }
          return pageRoute(const SelectActionPage(), settings);
        }
      case Routes.gettingStarted:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const GettingStartedPage(), settings);
          }
          return pageRoute(const GettingStartedPage(), settings);
        }
      case Routes.seedPhraseInfoChecklist:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(
              SeedPhraseInfoChecklistPage(),
              settings,
            );
          }
          return pageRoute(
            SeedPhraseInfoChecklistPage(),
            settings,
          );
        }
      case Routes.seedPhraseInstructions:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(
              const SeedPhraseInstructionsPage(),
              settings,
            );
          }
          return pageRoute(const SeedPhraseInstructionsPage(), settings);
        }
      case Routes.generateSeedPhrase:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(
              const SeedPhraseGeneratingPage(),
              settings,
            );
          }
          return pageRoute(const SeedPhraseGeneratingPage(), settings);
        }
      case Routes.displaySeedphrase:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(
              const SeedPhraseDisplayPage(),
              settings,
            );
          }
          return pageRoute(const SeedPhraseDisplayPage(), settings);
        }
      case Routes.seedPhraseConfirm:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(
              SeedPhraseConfirmationPage(),
              settings,
            );
          }
          return pageRoute(SeedPhraseConfirmationPage(), settings);
        }
      case Routes.walletInfoChecklist:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(
              const WalletInfoChecklistPage(),
              settings,
            );
          }
          return pageRoute(const WalletInfoChecklistPage(), settings);
        }
      case Routes.createPassword:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(CreatePasswordPage(), settings);
          }
          return pageRoute(CreatePasswordPage(), settings);
        }
      case Routes.extensionInfo:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const ExtensionInfoPage(), settings);
          }
          return pageRoute(const ExtensionInfoPage(), settings);
        }
      case Routes.login:
        {
          if (kIsWeb) return pageRouteNotAnimated(const LoginPage(), settings);
          return pageRoute(const LoginPage(), settings);
        }
      case Routes.walletCreated:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const WalletCreatedPage(), settings);
          }
          return pageRoute(const WalletCreatedPage(), settings);
        }
      case Routes.home:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const HomePage(), settings);
          }
          return pageRoute(const HomePage(), settings);
        }
      case Routes.assetsTransferInput:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const AssetTransferPage(), settings);
          }
          return pageRouteNotAnimated(const AssetTransferPage(), settings);
        }
      case Routes.restoreWallet:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const RestoreWalletPage(), settings);
          }
          return pageRoute(const RestoreWalletPage(), settings);
        }
      case Routes.restoreWithToplKey:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(
              const RestoreWithToplKeyPage(),
              settings,
            );
          }
          return pageRoute(const RestoreWithToplKeyPage(), settings);
        }
      case Routes.restoreWalletNewPassword:
        {
          final String seedPhrase = settings.arguments as String;
          if (kIsWeb) {
            return pageRouteNotAnimated(
              NewWalletPasswordPage(
                seedPhrase: seedPhrase,
              ),
              settings,
            );
          }
          return pageRoute(
            NewWalletPasswordPage(
              seedPhrase: seedPhrase,
            ),
            settings,
          );
        }
      case Routes.onboardingEnableBiometrics:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const EnableBiometrics(), settings);
          }
          return pageRoute(const EnableBiometrics(), settings);
        }
      case Routes.enterWalletPassword:
        {
          final String keyStoreJson = settings.arguments as String;
          if (kIsWeb) {
            return pageRouteNotAnimated(
              EnterWalletPasswordPage(toplKeyStoreJson: keyStoreJson),
              settings,
            );
          }
          return pageRoute(
            EnterWalletPasswordPage(toplKeyStoreJson: keyStoreJson),
            settings,
          );
        }
      case Routes.txReview:
        {
          final TransferDetails transferDetails = settings.arguments as TransferDetails;

          if (kIsWeb) {
            return pageRouteNotAnimated(
              TxReviewPage(transferDetails: transferDetails),
              settings,
            );
          }
          return pageRoute(
            TxReviewPage(transferDetails: transferDetails),
            settings,
          );
        }
      case Routes.txConfirmation:
        {
          final TransferDetails transferDetails = settings.arguments as TransferDetails;
          if (kIsWeb) {
            return pageRouteNotAnimated(
              TxConfirmationPage(transferDetails: transferDetails),
              settings,
            );
          }
          return pageRoute(
            TxConfirmationPage(transferDetails: transferDetails),
            settings,
          );
        }
      case Routes.mintInput:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const MintInputPage(), settings);
          }
          return pageRoute(
            const MintInputPage(),
            settings,
          );
        }
      case Routes.txHistoryDetails:
        final Map transactionDetailsMap = settings.arguments as Map;
        final RibnActivityDetailsModel transactionDetails = RibnActivityDetailsModel.fromJson(
          jsonEncode(transactionDetailsMap),
        );
        {
          return pageRoute(
            TxHistoryDetailsPage(ribnActivityDetailsModel: transactionDetails),
            settings,
          );
        }
      case Routes.assetDetails:
        {
          final Map<String, dynamic> assetDetailsPageArgs = settings.arguments as Map<String, dynamic>;
          if (kIsWeb) {
            return pageRouteNotAnimated(
              AssetDetailsPage(asset: assetDetailsPageArgs['assetAmount']!),
              settings,
            );
          }
          return pageRoute(
            AssetDetailsPage(asset: assetDetailsPageArgs['assetAmount']!),
            settings,
          );
        }
      case Routes.txHistory:
        {
          return pageRoute(const TxHistoryPage(), settings);
        }

      case Routes.settings:
        {
          if (kIsWeb) {
            return pageRouteNotAnimated(const SettingsPage(), settings);
          }
          return pageRoute(const SettingsPage(), settings);
        }
      case Routes.enable:
        {
          final InternalMessage pendingRequest = settings.arguments as InternalMessage;
          if (kIsWeb) {
            return pageRouteNotAnimated(EnablePage(pendingRequest), settings);
          }
          return pageRoute(EnablePage(pendingRequest), settings);
        }
      case Routes.externalSigning:
        {
          final InternalMessage pendingRequest = settings.arguments as InternalMessage;
          if (kIsWeb) {
            return pageRouteNotAnimated(
              ExternalSigningPage(pendingRequest),
              settings,
            );
          }
          return pageRoute(ExternalSigningPage(pendingRequest), settings);
        }
      case Routes.error:
        {
          final String errorMessage = (settings.arguments ?? 'Unknown error occurred') as String;
          return errorRoute(errorMsg: errorMessage);
        }
      case Routes.connectDApp:
        {
          final InternalMessage pendingRequest = settings.arguments as InternalMessage;
          return pageRouteNotAnimated(ConnectDApp(pendingRequest), settings);
        }
      case Routes.reviewAndSignDApp:
        {
          final InternalMessage pendingRequest = settings.arguments as InternalMessage;
          if (kIsWeb) {
            return pageRouteNotAnimated(
              ReviewAndSignDApp(pendingRequest),
              settings,
            );
          }
          return pageRoute(ReviewAndSignDApp(pendingRequest), settings);
        }
      case Routes.loadingDApp:
        {
          final InternalMessage response = settings.arguments as InternalMessage;
          return pageRouteNotAnimated(
            LoadingDApp(response: response),
            settings,
          );
        }
      default:
        return errorRoute();
    }
  }

  Route<MaterialPageRoute> errorRoute({
    String errorMsg = 'Unknown error occurred',
  }) {
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

  /// Builds a page route with an animation.
  Route<MaterialPageRoute> pageRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => page, settings: settings);
  }

  /// Builds a page route without an animation.
  Route<MaterialPageRoute> pageRouteNotAnimated(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
