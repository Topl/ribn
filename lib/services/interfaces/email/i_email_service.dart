import '../../../models/email/email_model.dart';
import '../../../models/email/email_response_model.dart';

/**
 * @dev This file contains the base functions required for sending an email
 * @author brianspha
 */
abstract class IEmailService {
  Future<EmailResponseModel> sendEmail(EmailModel model);
}
