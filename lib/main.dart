// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/v1/actions/internal_message_actions.dart';
import 'package:ribn/v1/constants/keys.dart';
import 'package:ribn/v1/constants/routes.dart' as v1Routes;
import 'package:ribn/v1/constants/rules.dart';
import 'package:ribn/v1/models/app_state.dart';
import 'package:ribn/v1/models/internal_message.dart';
import 'package:ribn/v1/platform/platform.dart';
import 'package:ribn/v1/presentation/authorize_and_sign/connect_dapp.dart';
import 'package:ribn/v1/presentation/authorize_and_sign/review_and_sign.dart';
import 'package:ribn/v1/presentation/enable_page.dart';
import 'package:ribn/v1/presentation/external_signing_page.dart';
import 'package:ribn/v1/presentation/home/home_page.dart';
import 'package:ribn/v1/presentation/login/login_page.dart';
import 'package:ribn/v1/presentation/onboarding/create_wallet/welcome_page.dart' as v1WelcomePage;
import 'package:ribn/v1/providers/store_provider.dart';
import 'package:ribn/v1/redux.dart';
import 'package:ribn/v1/router/root_router.dart';
import 'package:ribn/v2/shared/constants/routes.dart' as v2Routes;
import 'package:ribn/v2/onboarding/widgets/pages/welcome_page.dart';
import 'package:ribn/v2/asset_managment/screens/asset_managment_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Redux.initStore(initTestStore: kDebugMode ? true : false);
  final AppViews currentAppView = await PlatformUtils.instance.getCurrentAppView();
  final bool needsOnboarding = Redux.store!.state.needsOnboarding();
  // Open app in new tab if user needs onboarding
  if (currentAppView == AppViews.extension && needsOnboarding) {
    await PlatformUtils.instance.openInNewTab();
    // Initiate background connection if new window/tab opens up for dApp interaction.
  } else if (currentAppView == AppViews.extensionTab && !needsOnboarding) {
    await initBgConnection(Redux.store!);
    // Wallet().setJSCallbackFunction(_test());
    // initialize();
  } //@dev call this function to setup any singletons required by app
  runApp(
    ProviderScope(
      child: RibnApp(Redux.store!),
      overrides: [
        storeProvider.overrideWithValue(Redux.store!),
      ],
    ),
  );
}

class RibnApp extends StatelessWidget {
  final Store<AppState> store;
  final RootRouter rootRouter = RootRouter();

  RibnApp(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Portal(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ribn',
          navigatorObservers: [v1Routes.Routes.routeObserver],
          // onGenerateRoute: rootRouter.generateRoutes,
          onGenerateRoute: rootRouter.generateRoutes,
          onGenerateInitialRoutes: (initialRoute) => onGenerateInitialRoute(initialRoute, store),
          initialRoute: getInitialRoute(store),
          navigatorKey: Keys.navigatorKey,
        ),
      ),
    );
  }
}

Navigator getNavigator() {
  return Navigator(
    pages: const [
      MaterialPage(
        child: WelcomePage(),
      ),
    ],
    onPopPage: (route, result) => route.didPop(result),
  );
}

String getInitialRoute(Store<AppState> store) {
  return v2Routes.Routes.home;
}

/// Handles routing based on [initialRoute].
///
/// Note: For all cases, [RouteSettings] must be passed with the correct route name
/// to ensure consistent navigation in the app.
List<Route> onGenerateInitialRoute(initialRoute, Store<AppState> store) {
  switch (initialRoute) {
    case v2Routes.Routes.welcome:
      return [
        MaterialPageRoute(
            builder: (context) => WelcomePage(),
            // builder: (context) => OnboardingFlowPage(),
            // builder: (context) => CongratsPage(),
            settings: RouteSettings(name: v2Routes.Routes.welcome))
      ];
    case v2Routes.Routes.home:
      return [
        MaterialPageRoute(
          builder: (context) => AssetManagementScreen(),
          settings: RouteSettings(name: v2Routes.Routes.home),
        ),
      ];
    //v1
    case v1Routes.Routes.login:
      return [
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: const RouteSettings(name: v1Routes.Routes.login),
        )
      ];
    case v1Routes.Routes.home:
      return [
        MaterialPageRoute(builder: (context) => const HomePage(), settings: RouteSettings(name: v1Routes.Routes.home))
      ];
    case v1Routes.Routes.enable:
      return [
        MaterialPageRoute(
          builder: (context) => EnablePage(store.state.internalMessage!),
          settings: const RouteSettings(name: v1Routes.Routes.enable),
        )
      ];
    case v1Routes.Routes.externalSigning:
      return [
        MaterialPageRoute(
          builder: (context) => ExternalSigningPage(store.state.internalMessage!),
          settings: const RouteSettings(name: v1Routes.Routes.externalSigning),
        )
      ];

    //v2
    case v1Routes.Routes.connectDApp:
      return [
        MaterialPageRoute(
          builder: (context) => ConnectDApp(store.state.internalMessage!),
          settings: const RouteSettings(name: v1Routes.Routes.connectDApp),
        )
      ];
    case v1Routes.Routes.reviewAndSignDApp:
      return [
        MaterialPageRoute(
          builder: (context) => ReviewAndSignDApp(store.state.internalMessage!),
          settings: const RouteSettings(name: v1Routes.Routes.reviewAndSignDApp),
        )
      ];

    case v1Routes.Routes.welcome:
    default:
      return [
        MaterialPageRoute(
          builder: (context) => const v1WelcomePage.WelcomePage(),
          settings: const RouteSettings(name: v1Routes.Routes.welcome),
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
