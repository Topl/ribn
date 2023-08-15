// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

// Project imports:
import 'package:ribn/v1/constants/keys.dart';
import 'package:ribn/v1/constants/routes.dart' as v1Routes;
import 'package:ribn/v1/router/root_router.dart';
import 'package:ribn/v2/onboarding/screens/welcome_screen.dart';
import 'package:ribn/v2/receive_assets/screens/receive_asset_screen.dart';
import 'package:ribn/v2/recovery/screens/recover_wallet_screen.dart';
import 'package:ribn/v2/shared/constants/ui.dart';
import 'package:ribn/v2/shared/providers/app_theme_provider.dart';
import 'package:ribn/v2/shared/theme.dart';
import 'package:ribn/v2/shared/widgets/vnester/screen_scaffold.dart';
import 'package:vrouter/vrouter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  final RootRouter rootRouter = RootRouter();

  RibnApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VRouter(
      debugShowCheckedModeBanner: false,
      title: 'Ribn',
      theme: lightTheme(context: context),
      darkTheme: darkTheme(context: context),
      themeMode: ref.watch(appThemeColorProvider),
      navigatorObservers: [v1Routes.Routes.routeObserver],
      navigatorKey: Keys.navigatorKey,
      initialUrl: WelcomePage().route,
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
              path: RestoreWalletScreen().route,
              widget: RestoreWalletScreen(),
            ),
            // Any routes that require the user to be logged in should be nested in this VGuard
            VGuard(
              beforeEnter: (vRedirector) async {
                // Before enter, check if the user is logged in
                // If the user is not logged in, redirect them to the welcome page
              },
              stackedRoutes: [
                VWidget(
                  path: ReceiveAssets().route,
                  widget: ReceiveAssets(),
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
