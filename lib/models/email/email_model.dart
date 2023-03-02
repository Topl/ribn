import 'package:image_picker/image_picker.dart';

/**
 * @dev File contains Properties for for sending an email
 * @params attachments If the email has any images that need to be attached
 * @params subject Indicates the Subject to be attached to the email
 * @params email The actual body of the email
 */

class EmailModel {
  final String email;
  final String subject;
  final List<XFile> attachments;
  EmailModel({
    required this.email,
    required this.subject,
    required this.attachments,
  });
}
