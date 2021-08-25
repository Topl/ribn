import 'package:flutter/material.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/router/root_router.dart';
import 'package:ribn/middlewares/app_middleware.dart';
import 'package:ribn/models/app_state.dart';
import 'package:ribn/reducers/app_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final RootRouter rootRouter = RootRouter();
  final store = Store<AppState>(
    appReducer,
    middleware: appMiddleware,
    distinct: true,
    initialState: AppState.initial(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Ribn',
        onGenerateRoute: rootRouter.generateRoutes,
        initialRoute: Routes.welcome,
        navigatorKey: Keys.navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
      ),
    );
  }
}
