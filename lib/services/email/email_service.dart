import 'package:ribn/services/interfaces/email/i_email_service.dart';

import '../../models/email/email_model.dart';
import '../../models/email/email_response_model.dart';

class EmailService extends IEmailService {
  @override
  Future<EmailResponseModel> sendEmail(EmailModel email) async {
    /* final attachmentBytes = await attachment.readAsBytes();
    final attachmentBase64 = base64Encode(attachmentBytes);
    final response = await http.post(
      'https://www.googleapis.com/gmail/v1/users/me/messages/send',
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'raw': 'Content-Type: multipart/mixed; boundary="XXX"\n'
            'MIME-Version: 1.0\n'
            'To: $to\n'
            'Subject: $subject\n\n'
            '--XXX\n'
            'Content-Type: text/plain; charset="UTF-8"\n\n'
            '$message\n\n'
            '--XXX\n'
            'Content-Type: application/octet-stream; name="${attachment.path}"\n'
            'Content-Disposition: attachment; filename="${attachment.path}"\n'
            'Content-Transfer-Encoding: base64\n\n'
            '$attachmentBase64\n\n'
            '--XXX--',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send email');
    }*/
    return new EmailResponseModel(success: false, error: '', statusCode: 400);
  }
}
