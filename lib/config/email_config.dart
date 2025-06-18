import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailConfig {
  // Email de destino a partir das variáveis de ambiente
  static String get toEmail =>
      dotenv.env['TO_EMAIL'] ?? 'contact@zitskegroup.com';

  // Endpoint do Formspree a partir das variáveis de ambiente
  static String get _formspreeEndpoint {
    final formId = dotenv.env['FORMSPREE_FORM_ID'];
    if (formId == null || formId.isEmpty) {
      throw Exception('FORMSPREE_FORM_ID não encontrado no arquivo .env');
    }
    return 'https://formspree.io/f/$formId';
  }

  static Future<bool> sendEmail({
    required String firstName,
    required String lastName,
    required String email,
    required String subject,
    required String message,
    required String app,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_formspreeEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': '$firstName $lastName',
          'email': email,
          'subject': 'Suporte - $subject',
          'message': '''
Aplicação: $app
Nome: $firstName $lastName
Email: $email
Assunto: $subject

Mensagem:
$message
          ''',
          '_replyto': email,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Erro ao enviar email: $e');
      return false;
    }
  }
}
