import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/ai_conversation.dart';
import '../models/ai_message.dart';

class AIConversationService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // ==========================================================
  // Create Conversation
  // ==========================================================

  Future<AIConversation> createConversation() async {
    final user = _supabase.auth.currentUser!;

    final response = await _supabase
        .from('ai_conversations')
        .insert({'user_id': user.id, 'title': 'New Chat'})
        .select()
        .single();

    return AIConversation.fromMap(response);
  }

  // ==========================================================
  // Load Conversations
  // ==========================================================

  Future<List<AIConversation>> getConversations() async {
    final user = _supabase.auth.currentUser!;

    final response = await _supabase
        .from('ai_conversations')
        .select()
        .eq('user_id', user.id)
        .order('updated_at', ascending: false);

    return (response as List).map((e) => AIConversation.fromMap(e)).toList();
  }

  // ==========================================================
  // Load Messages
  // ==========================================================

  Future<List<AIMessage>> getMessages(String conversationId) async {
    final response = await _supabase
        .from('ai_messages')
        .select()
        .eq('conversation_id', conversationId)
        .order('created_at');

    return (response as List).map((e) => AIMessage.fromMap(e)).toList();
  }

  // ==========================================================
  // Save Message
  // ==========================================================

  Future<void> saveMessage(AIMessage message) async {
    await _supabase.from('ai_messages').insert(message.toMap());
  }

  // ==========================================================
  // Delete Conversation
  // ==========================================================

  Future<void> deleteConversation(String id) async {
    await _supabase.from('ai_conversations').delete().eq('id', id);
  }

  // ==========================================================
  // Rename Conversation
  // ==========================================================

  Future<void> renameConversation(String id, String title) async {
    await _supabase
        .from('ai_conversations')
        .update({
          'title': title,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }
}
