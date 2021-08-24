import 'package:flutter/material.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/router/root_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final RootRouter rootRouter = RootRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ribn',
      onGenerateRoute: rootRouter.generateRoutes,
      initialRoute: Routes.welcome,
      navigatorKey: Keys.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
    );
  }
}
