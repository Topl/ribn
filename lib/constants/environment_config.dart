class EnvironmentConfig {
  static const ASSIGNEE_ID =
      String.fromEnvironment('ASSIGNEE_ID', defaultValue: "");
  static const ISSUE_TYPE =
      String.fromEnvironment('ISSUE_TYPE', defaultValue: "");
  static const JIRA_ATTACH_ISSUE_URL =
      String.fromEnvironment('JIRA_ATTACH_ISSUE_URL', defaultValue: "");
  static const JIRA_CREATE_ISSUE_URL =
      String.fromEnvironment('JIRA_CREATE_ISSUE_URL', defaultValue: "");
  static const JIRA_DEFAULT_HEADERS =
      String.fromEnvironment('JIRA_DEFAULT_HEADERS', defaultValue: "");
  static const JIRA_DEFAULT_HEADERS_ATTACHMENTS = String.fromEnvironment(
      'JIRA_DEFAULT_HEADERS_ATTACHMENTS',
      defaultValue: "");
  static const PROJECT_KEY =
      String.fromEnvironment('PROJECT_KEY', defaultValue: "");
  static const JIRA_AUTH_TOKEN =
      String.fromEnvironment('JIRA_AUTH_TOKEN', defaultValue: "");
}
