// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
// Project imports:
import 'package:ribn/actions/internal_message_actions.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/platform/platform.dart';
import 'package:ribn/presentation/authorize_and_sign/connect_dapp.dart';
import 'package:ribn/presentation/authorize_and_sign/review_and_sign.dart';
import 'package:ribn/presentation/enable_page.dart';
import 'package:ribn/presentation/external_signing_page.dart';
import 'package:ribn/presentation/home/home_page.dart';
import 'package:ribn/presentation/login/login_page.dart';
import 'package:ribn/presentation/onboarding/create_wallet/welcome_page.dart';
import 'package:ribn/presentation/transaction_history/service_locator/locator.dart';
import 'package:ribn/redux.dart';
import 'package:ribn/router/root_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Redux.initStore(initTestStore: false);
  final AppViews currentAppView =
      await PlatformUtils.instance.getCurrentAppView();
  final bool needsOnboarding = Redux.store!.state.needsOnboarding();
  // Open app in new tab if user needs onboarding
  if (currentAppView == AppViews.extension && needsOnboarding) {
    await PlatformUtils.instance.openInNewTab();
    // Initiate background connection if new window/tab opens up for dApp interaction.
  } else if (currentAppView == AppViews.extensionTab && !needsOnboarding) {
    await initBgConnection(Redux.store!);
    // Wallet().setJSCallbackFunction(_test());
    // initialize();
  }
  setupLocator(
    Redux.store!,
  ); //@dev call this function to setup any singletons required by app
  runApp(RibnApp(Redux.store!));
}

class RibnApp extends StatefulWidget {
  final Store<AppState> store;

  RibnApp(this.store, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RinAppState();
  }
}

class _RinAppState extends State<RibnApp> {
  late RootRouter rootRouter;

  @override
  void initState() {
    setState(() {
      rootRouter = RootRouter();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Portal(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ribn',
          navigatorObservers: [Routes.routeObserver],
          onGenerateRoute: rootRouter.generateRoutes,
          onGenerateInitialRoutes: (initialRoute) =>
              onGenerateInitialRoute(initialRoute, widget.store),
          initialRoute: getInitialRoute(widget.store),
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

  //v2
  else if (store.state.internalMessage?.method == InternalMethods.authorize) {
    return Routes.connectDApp;
  } else if (store.state.internalMessage?.method ==
      InternalMethods.getBalance) {
    return Routes.reviewAndSignDApp;
  } else if (store.state.internalMessage?.method ==
      InternalMethods.signTransaction) {
    return Routes.reviewAndSignDApp;
  }

  return Routes.home;
}

/// Handles routing based on [initialRoute].
///
/// Note: For all cases, [RouteSettings] must be passed with the correct route name
/// to ensure consistent navigation in the app.
List<Route> onGenerateInitialRoute(initialRoute, Store<AppState> store) {
  switch (initialRoute) {
    case Routes.login:
      return [
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: const RouteSettings(name: Routes.login),
        )
      ];
    case Routes.home:
      if (store.state.internalMessage?.additionalNavigation == Routes.home) {
        return [
          MaterialPageRoute(
            builder: (context) => ConnectDApp(store.state.internalMessage!),
            settings: const RouteSettings(name: Routes.connectDApp),
          )
        ];
      }
      return [
        MaterialPageRoute(
            builder: (context) => const HomePage(),
            settings: RouteSettings(name: Routes.home))
      ];
    case Routes.enable:
      return [
        MaterialPageRoute(
          builder: (context) => EnablePage(store.state.internalMessage!),
          settings: const RouteSettings(name: Routes.enable),
        )
      ];
    case Routes.externalSigning:
      return [
        MaterialPageRoute(
          builder: (context) =>
              ExternalSigningPage(store.state.internalMessage!),
          settings: const RouteSettings(name: Routes.externalSigning),
        )
      ];

    //v2
    case Routes.connectDApp:
      return [
        MaterialPageRoute(
          builder: (context) => ConnectDApp(store.state.internalMessage!),
          settings: const RouteSettings(name: Routes.connectDApp),
        )
      ];
    case Routes.reviewAndSignDApp:
      return [
        MaterialPageRoute(
          builder: (context) => ReviewAndSignDApp(store.state.internalMessage!),
          settings: const RouteSettings(name: Routes.reviewAndSignDApp),
        )
      ];

    case Routes.welcome:
    default:
      return [
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
          settings: const RouteSettings(name: Routes.welcome),
        )
      ];
  }
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
      final InternalMessage pendingRequest =
          InternalMessage.fromJson(msgFromBgScript);
      store.dispatch(ReceivedInternalMsgAction(pendingRequest));
      completer.complete();
    });
    Messenger.instance
        .sendMsg(jsonEncode({'method': InternalMethods.checkPendingRequest}));
  } catch (e) {
    completer.complete();
    PlatformUtils.instance.closeWindow();
  }
  return completer.future;
}
