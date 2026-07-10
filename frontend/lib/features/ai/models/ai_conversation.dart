class AIConversation {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AIConversation({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AIConversation.fromMap(Map<String, dynamic> map) {
    return AIConversation(
      id: map['id'],
      title: map['title'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  AIConversation copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AIConversation(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
