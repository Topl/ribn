import 'package:hooks_riverpod/hooks_riverpod.dart';

final environmentProvider = Provider((ref) => EnvironmentConfig());

class EnvironmentConfig {
  static const nightlyBuildVersion =
      String.fromEnvironment('nightlyBuildVersion', defaultValue: "");
}
