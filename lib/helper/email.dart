import 'package:http/http.dart' as http;
import 'dart:convert';

void enviaEmail(
    String nome, String email, String mensagem, String titulo) async {
  final serviceId = 'service_9vsolgp';
  final templateId = 'template_96loq14';
  final userId = '-wM326OCudF4bXuqT';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'user_name': nome,
        'user_email': email,
        'user_subject': titulo,
        'user_mensage': mensagem,
      }
    }),
  );
}
