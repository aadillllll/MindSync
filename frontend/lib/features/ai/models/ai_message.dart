enum MessageRole { user, assistant, system }

class AIMessage {
  final String id;
  final String conversationId;
  final MessageRole role;
  final String content;
  final DateTime createdAt;

  const AIMessage({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  factory AIMessage.fromMap(Map<String, dynamic> map) {
    return AIMessage(
      id: map['id'],
      conversationId: map['conversation_id'],
      role: MessageRole.values.firstWhere((e) => e.name == map['role']),
      content: map['content'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'role': role.name,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }

  AIMessage copyWith({
    String? id,
    String? conversationId,
    MessageRole? role,
    String? content,
    DateTime? createdAt,
  }) {
    return AIMessage(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
