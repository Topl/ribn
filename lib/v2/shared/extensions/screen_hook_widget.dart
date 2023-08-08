import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class ScreenWidget extends HookWidget {
  // Route for the screen
  final String route;

  // Path for the screen
  // EX.
  // ```
  // String pathWithParam(String transactionId) {
  // return '$route$transactionId';
  // }
  //
  // // In Use:
  // context.vRouter.to(TransactionDetailsPage.pathWithParam(row.transactionId));
  // ```
  final Function(String)? path;

  const ScreenWidget({
    required this.route,
    this.path,
    Key? key,
  }) : super(key: key);
}

abstract class ScreenConsumerWidget extends HookConsumerWidget {
  // Route for the screen
  final String route;

  // Path for the screen
  // EX.
  // ```
  // String pathWithParam(String transactionId) {
  // return '$route$transactionId';
  // }
  //
  // // In Use:
  // context.vRouter.to(TransactionDetailsPage.pathWithParam(row.transactionId));
  // ```
  final Function(String)? pathWithParam;

  const ScreenConsumerWidget({
    required this.route,
    this.pathWithParam,
    Key? key,
  }) : super(key: key);
}
