class EnvironmentConfig {
  static const nightlyBuildVersion =
      String.fromEnvironment('nightlyBuildVersion', defaultValue: "");

  // KEYS
  static const jiraSecret = String.fromEnvironment('jiraSecret', defaultValue:"");
}
