// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/v1/constants/keys.dart';
import 'package:ribn/v1/constants/routes.dart' as v1Routes;
import 'package:ribn/v1/models/app_state.dart';

import 'package:ribn/v1/redux.dart';
import 'package:ribn/v1/router/root_router.dart';
import 'package:ribn/v2/onboarding/screens/welcome_screen.dart';
import 'package:ribn/v2/shared/providers/app_theme_provider.dart';
import 'package:ribn/v2/shared/theme.dart';
import 'package:ribn/v2/shared/widgets/vnester/screen_scaffold.dart';
import 'package:vrouter/vrouter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final AppViews currentAppView = await PlatformUtils.instance.getCurrentAppView();

  runApp(
    ProviderScope(
      child: RibnApp(Redux.store!),
    ),
  );
}

class RibnApp extends HookConsumerWidget {
  final Store<AppState> store;
  final RootRouter rootRouter = RootRouter();

  RibnApp(this.store, {Key? key}) : super(key: key);

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
        VNester(
          path: '/',
          widgetBuilder: (child) => ScreenScaffold(child: child),
          nestedRoutes: [
            VWidget(
              path: WelcomePage().route,
              widget: WelcomePage(),
            ),
            VGuard(
              beforeEnter: (vRedirector) async {
                // Before enter, check if the user is logged in
                // If the user is not logged in, redirect them to the welcome page
              },
              stackedRoutes: [],
            )
          ],
        ),
      ],
    );
  }
}


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
