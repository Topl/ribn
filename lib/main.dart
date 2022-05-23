import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/internal_message_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/presentation/enable_page.dart';
import 'package:ribn/presentation/external_signing_page.dart';
import 'package:ribn/presentation/home/home_page.dart';
import 'package:ribn/presentation/login/login_page.dart';
import 'package:ribn/presentation/onboarding/welcome_page.dart';
import 'package:ribn/redux.dart';
import 'package:ribn/router/root_router.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Redux.initStore(initTestStore: false);
  final String currentAppView = await PlatformUtils.instance.getCurrentAppView();
  final bool needsOnboarding = Redux.store!.state.needsOnboarding();
  // Open app in new tab if user needs onboarding
  if (currentAppView == 'extension' && needsOnboarding) {
    await PlatformUtils.instance.openInNewTab();
    // Initiate background connection if new window/tab opens up for dApp interaction.
  } else if (currentAppView == 'tab' && !needsOnboarding) {
    await initBgConnection(Redux.store!);
  }

  runApp(MyApp(Redux.store!));
}

class MyApp extends StatelessWidget {
  final RootRouter rootRouter = RootRouter();
  final Store<AppState> store;
  MyApp(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Portal(
        child: MaterialApp(
          title: 'Ribn',
          navigatorObservers: [Routes.routeObserver],
          onGenerateRoute: rootRouter.generateRoutes,
          onGenerateInitialRoutes: (String route) {
            switch (route) {
              case Routes.login:
                return [MaterialPageRoute(builder: (context) => const LoginPage())];
              case Routes.home:
                return [MaterialPageRoute(builder: (context) => const HomePage())];
              case Routes.enable:
                return [MaterialPageRoute(builder: (context) => EnablePage(store.state.internalMessage!))];
              case Routes.externalSigning:
                return [MaterialPageRoute(builder: (context) => ExternalSigningPage(store.state.internalMessage!))];
              default:
                return [
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                    settings: const RouteSettings(
                      name: Routes.welcome,
                    ),
                  )
                ];
            }
          },
          initialRoute: getInitialRoute(store),
          navigatorKey: Keys.navigatorKey,
        ),
      ),
    );
  }
}

String getInitialRoute(Store<AppState> store) {
  if (store.state.needsOnboarding()) {
    return Routes.welcome;
  } else if (store.state.needsLogin()) {
    return Routes.login;
  } else if (store.state.internalMessage?.method == InternalMethods.enable) {
    return Routes.enable;
  } else if (store.state.internalMessage?.method == InternalMethods.signTx) {
    return Routes.externalSigning;
  }
  return Routes.home;
}

/// Initiates a long-lived connection with the background script.
///
/// A port message listener is added, and a message is sent to check for pending requests.
/// The future completes upon receiving a response.
Future<void> initBgConnection(Store<AppState> store) async {
  final Completer<void> completer = Completer<void>();
  try {
    Messenger.instance.connect();
    Messenger.instance.initMsgListener((String msgFromBgScript) {
      final InternalMessage pendingRequest = InternalMessage.fromJson(msgFromBgScript);
      store.dispatch(ReceivedInternalMsgAction(pendingRequest));
      completer.complete();
    });
    Messenger.instance.sendMsg(jsonEncode({'method': InternalMethods.checkPendingRequest}));
  } catch (e) {
    completer.complete();
    PlatformUtils.instance.closeWindow();
  }
  return completer.future;
}
