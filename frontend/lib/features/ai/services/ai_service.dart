import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/chat_message.dart';

class AIService {
  static const String baseUrl = "http://10.0.2.2:8000";

  Future<Map<String, dynamic>> sendMessage(
    String message,
    List<ChatMessage> history,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/ai/chat"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "message": message,
        "history": history.map((e) => e.toJson()).toList(),
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(response.body);
  }
}
