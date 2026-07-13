import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/chat_message.dart';

class AIService {
  // Android Emulator
  static const String baseUrl = "http://10.0.2.2:8000";

  // Windows
  // static const String baseUrl = "http://127.0.0.1:8000";

  Future<Map<String, dynamic>> sendMessage(
    String message,
    List<ChatMessage> history,
  ) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in.");
    }

    final response = await http.post(
      Uri.parse("$baseUrl/ai/chat"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": user.id,
        "message": message,
        "history": history
            .map(
              (e) => {
                "role": e.isUser ? "user" : "assistant",
                "content": e.text,
              },
            )
            .toList(),
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(response.body);
  }
}
