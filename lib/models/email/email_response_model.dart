/**
 * @dev File contains Properties returned by the API for sending an email
 * @params success indicates if the email was sent or not
 * @params error Indicates if there was an error sending the email and the actual error returned
 * @params statusCode indicates if the status code returned by the API
 */

class EmailResponseModel {
  final bool success;
  final String error;
  final int statusCode;
  EmailResponseModel({
    required this.success,
    required this.error,
    required this.statusCode,
  });
}
