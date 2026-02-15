import 'package:envied/envied.dart';
import 'package:http/http.dart' as http;

import '../extension/common_extension.dart';

part 'email_manager.g.dart';

@Envied(path: 'config/.env')
class EmailService {
  static final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static final EmailService _instance = EmailService._();
  static final Uri _baseUri = Uri.https('api.emailjs.com');

  @EnviedField(varName: 'SERVICE_ID', obfuscate: true)
  static final String _serviceId = _EmailService._serviceId;

  @EnviedField(varName: 'TEMPLATE_ID', obfuscate: true)
  static final String _templateId = _EmailService._templateId;

  @EnviedField(varName: 'PUBLIC_KEY', obfuscate: true)
  static final String _userId = _EmailService._userId;

  const EmailService._();

  factory EmailService() {
    return _instance;
  }

  Future<void> sendEmail(EmailPayload payload) async {
    await _baseUri
        .replace(
          path: '/api/v1.0/email/send',
          queryParameters: {
            'service_id': _serviceId,
            'template_id': _templateId,
            'user_id': _userId,
            'template_params': payload.toJson(),
          },
        )
        .let(http.get);
  }
}

class EmailPayload {
  final String fromEmail;
  final String title;
  final String message;

  const EmailPayload({
    required this.fromEmail,
    required this.title,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'from_email': fromEmail,
      'title': title,
      'message': message,
    };
  }
}
