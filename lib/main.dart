import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/models/internal_message.dart';
import 'package:ribn/presentation/enable_page.dart';
import 'package:ribn/presentation/external_signing_page.dart';
import 'package:ribn/presentation/login_page.dart';
import 'package:ribn/presentation/welcome_page.dart';
import 'package:ribn/redux.dart';
import 'package:ribn/router/root_router.dart';

void main() async {
  await Redux.initStore();
  final String msg = await Redux.initBgConnection();
  InternalMessage? pendingRequest;
  if (msg.isNotEmpty) pendingRequest = InternalMessage.fromJson(msg);
  runApp(MyApp(Redux.store!, pendingRequest));
}

class MyApp extends StatelessWidget {
  MyApp(this.store, this.pendingRequest, {Key? key}) : super(key: key);
  final RootRouter rootRouter = RootRouter();
  final Store<AppState> store;
  final InternalMessage? pendingRequest;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Ribn',
        onGenerateRoute: rootRouter.generateRoutes,
        onGenerateInitialRoutes: (String route) {
          switch (route) {
            case Routes.externalSigning:
              return [MaterialPageRoute(builder: (context) => ExternalSigningPage(pendingRequest!))];
            case Routes.enable:
              return [MaterialPageRoute(builder: (context) => EnablePage(pendingRequest!))];
            case Routes.login:
              return [MaterialPageRoute(builder: (context) => const LoginPage())];
            default:
              return [MaterialPageRoute(builder: (context) => const WelcomePage())];
          }
        },
        initialRoute: getInitialRoute(store, pendingRequest),
        navigatorKey: Keys.navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
      ),
    );
  }
}

String getInitialRoute(
  Store<AppState> store,
  InternalMessage? pendingRequest,
) {
  switch (pendingRequest?.method) {
    case Strings.signTx:
      {
        return Routes.externalSigning;
      }
    case Strings.enable:
      {
        return Routes.enable;
      }
    default:
      {
        return store.state.keyStoreExists() ? Routes.login : Routes.welcome;
      }
  }
}
