import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ribn/actions/internal_message_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/data/data.dart' as local;
import 'package:ribn/data/data_web.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/presentation/login/login_page.dart';
import 'package:ribn/presentation/onboarding/welcome_page.dart';
import 'package:ribn/redux.dart';
import 'package:ribn/router/root_router.dart';

void main() async {
  await Redux.initStore(initTestStore: true);
  final String currentAppView = await getCurrentAppView();
  final bool needsOnboarding = Redux.store!.state.needsOnboarding();
  // Open app in new tab if user needs onboarding
  if (currentAppView == 'extension' && needsOnboarding) {
    await openAppInNewTab();
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
          debugShowCheckedModeBanner: false,
          title: 'Ribn',
          navigatorObservers: [Routes.routeObserver],
          onGenerateRoute: rootRouter.generateRoutes,
          onGenerateInitialRoutes: (String route) {
            switch (route) {
              case Routes.login:
                return [MaterialPageRoute(builder: (context) => const LoginPage())];
              default:
                return [MaterialPageRoute(builder: (context) => const WelcomePage())];
            }
          },
          initialRoute: getInitialRoute(store),
          navigatorKey: Keys.navigatorKey,
        ),
      ),
    );
  }
}

String getInitialRoute(Store<AppState> store) => store.state.needsOnboarding() ? Routes.welcome : Routes.login;

/// Initiates a long-lived connection with the background script.
///
/// A port message listener is added, and a message is sent to check for pending requests.
/// The future completes upon receiving a response.
Future<void> initBgConnection(Store<AppState> store) async {
  final Completer<void> completer = Completer<void>();
  try {
    local.connectToBackground();
    local.initPortMessageListener((String msgFromBgScript) {
      final InternalMessage pendingRequest = InternalMessage.fromJson(msgFromBgScript);
      store.dispatch(ReceivedInternalMsgAction(pendingRequest));
      completer.complete();
    });
    local.sendPortMessage(jsonEncode({'method': InternalMethods.checkPendingRequest}));
  } catch (e) {
    completer.complete();
    local.closeWindow();
  }
  return completer.future;
}
