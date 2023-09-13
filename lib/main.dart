// Flutter imports:
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ribn/v2/activity/screens/activity_screen.dart';
import 'package:ribn/v2/asset_managment/screens/asset_managment_screen.dart';

// Project imports:
import 'package:ribn/v2/onboarding/screens/welcome_screen.dart';
import 'package:ribn/v2/onboarding/widgets/pages/congratulations.dart';
import 'package:ribn/v2/onboarding/widgets/pages/onboarding_flow_page.dart';
import 'package:ribn/v2/receive_assets/screens/receive_asset_screen.dart';
import 'package:ribn/v2/recovery/screens/recover_wallet_screen.dart';
import 'package:ribn/v2/shared/constants/keys.dart';
import 'package:ribn/v2/send_assets/screens/send_asset_screen.dart';
import 'package:ribn/v2/shared/constants/ui.dart';
import 'package:ribn/v2/shared/providers/app_theme_provider.dart';
import 'package:ribn/v2/shared/theme.dart';
import 'package:ribn/v2/shared/widgets/vnester/screen_scaffold.dart';
import 'package:ribn/v2/user/models/user.dart';
import 'package:ribn/v2/user/providers/user_provider.dart';

import 'package:vrouter/vrouter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // final AppViews currentAppView = await PlatformUtils.instance.getCurrentAppView();

  runApp(
    ProviderScope(
      child: ResponsiveBreakpoints.builder(
        child: RibnApp(),
        breakpoints: const [
          Breakpoint(start: 0, end: mobileBreak, name: MOBILE),
          Breakpoint(start: mobileBreak + 1, end: tabletBreak, name: TABLET),
          Breakpoint(start: tabletBreak + 1, end: double.infinity, name: DESKTOP),
        ],
      ),
    ),
  );
}

class RibnApp extends HookConsumerWidget {
  RibnApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VRouter(
      debugShowCheckedModeBanner: false,
      title: 'Ribn',
      theme: lightTheme(context: context),
      darkTheme: darkTheme(context: context),
      themeMode: ref.watch(appThemeColorProvider),
      navigatorObservers: [],
      navigatorKey: Keys.navigatorKey,
      initialUrl: SendAssetScreen().route,
      routes: [
        // Wraps all routes in a ScreenScaffold
        VNester(
          path: '/',
          widgetBuilder: (child) => ScreenScaffold(child: child),
          nestedRoutes: [
            VWidget(
              path: WelcomePage().route,
              widget: WelcomePage(),
            ),
            VWidget(
              path: OnboardingFlowPage().route,
              widget: OnboardingFlowPage(),
            ),

            VWidget(
              path: CongratulationSeedPhrase().route,
              widget: CongratulationSeedPhrase(),
            ),
            VWidget(
              path: RestoreWalletScreen().route,
              widget: RestoreWalletScreen(),
            ),
            // Any routes that require the user to be logged in should be nested in this VGuard
            VGuard(
              beforeEnter: (vRedirector) async {
                // Before enter, check if the user is logged in
                // If the user is not logged in, redirect them to the welcome page
                final User? user = ref.read(userProvider).asData?.value;
                if (user == null) {
                  vRedirector.to(WelcomePage().route);
                }
              },
              stackedRoutes: [
                VWidget(
                  path: ReceiveAssets().route,
                  widget: ReceiveAssets(),
                ),
                VWidget(
                  path: AssetManagementScreen().route,
                  widget: AssetManagementScreen(),
                ),
                VWidget(
                  path: SendAssetScreen().route, // Transaction details screen
                  widget: SendAssetScreen(),
                ),
                VWidget(
                  path: ActivityScreen().route, // Activity screen
                  widget: ActivityScreen(),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

// LEAVING THIS COMMENTED FOR NOW
// This will be needed in the future
/// Initiates a long-lived connection with the background script.
///
/// A port message listener is added, and a message is sent to check for pending requests.
/// The future completes upon receiving a response.
// Future<void> initBgConnection(Store<AppState> store) async {
//   final Completer<void> completer = Completer<void>();
//   try {
//     Messenger.instance.connect();
//     Messenger.instance.initMsgListener((String msgFromBgScript) {
//       final InternalMessage pendingRequest = InternalMessage.fromJson(msgFromBgScript);
//       store.dispatch(ReceivedInternalMsgAction(pendingRequest));
//       completer.complete();
//     });
//     Messenger.instance.sendMsg(jsonEncode({'method': InternalMethods.checkPendingRequest}));
//   } catch (e) {
//     completer.complete();
//     PlatformUtils.instance.closeWindow();
//   }
//   return completer.future;
// }
