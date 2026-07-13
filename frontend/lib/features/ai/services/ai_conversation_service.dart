import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/ai_conversation.dart';
import '../models/chat_message.dart';

class AIConversationService {
  final _supabase = Supabase.instance.client;

  Future<String> createConversation() async {
    final user = _supabase.auth.currentUser!;

    final data = await _supabase
        .from('ai_conversations')
        .insert({'user_id': user.id, 'title': 'New Chat'})
        .select()
        .single();

    return data['id'];
  }

  Future<void> saveMessage({
    required String conversationId,
    required String role,
    required String content,
  }) async {
    await _supabase.from('ai_messages').insert({
      'conversation_id': conversationId,
      'role': role,
      'content': content,
    });

    await _supabase
        .from('ai_conversations')
        .update({'updated_at': DateTime.now().toIso8601String()})
        .eq('id', conversationId);
  }

  Future<List<AIConversation>> getConversations() async {
    final user = _supabase.auth.currentUser!;

    final data = await _supabase
        .from('ai_conversations')
        .select()
        .eq('user_id', user.id)
        .order('updated_at', ascending: false);

    return data.map<AIConversation>((e) => AIConversation.fromMap(e)).toList();
  }

  Future<List<ChatMessage>> getMessages(String conversationId) async {
    final data = await _supabase
        .from('ai_messages')
        .select()
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: true);

    return data
        .map<ChatMessage>(
          (e) => ChatMessage(text: e['content'], isUser: e['role'] == 'user'),
        )
        .toList();
  }

  Future<void> deleteConversation(String id) async {
    await _supabase.from('ai_conversations').delete().eq('id', id);
  }

  Future<void> updateTitle(String conversationId, String title) async {
    await _supabase
        .from("ai_conversations")
        .update({"title": title})
        .eq("id", conversationId);
  }
}
