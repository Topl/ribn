import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/redux.dart';
import 'package:ribn/router/root_router.dart';

void main() async {
  await Redux.init();
  runApp(MyApp(Redux.store!));
}

class MyApp extends StatelessWidget {
  MyApp(this.store, {Key? key}) : super(key: key);
  final RootRouter rootRouter = RootRouter();
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Ribn',
        onGenerateRoute: rootRouter.generateRoutes,
        initialRoute: store.state.keyStoreExists() ? Routes.login : Routes.welcome,
        navigatorKey: Keys.navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
      ),
    );
  }
}
