class NoteModel {
  final String id;
  final String userId;

  final String title;
  final String content;

  final String category;

  final bool isPinned;
  final bool isFavorite;

  // ==========================
  // Attachments
  // ==========================

  final String? attachmentUrl;
  final String? attachmentName;
  final String? attachmentType;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const NoteModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    this.category = "General",
    this.isPinned = false,
    this.isFavorite = false,
    this.attachmentUrl,
    this.attachmentName,
    this.attachmentType,
    this.createdAt,
    this.updatedAt,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      category: map['category'] ?? 'General',
      isPinned: map['is_pinned'] ?? false,
      isFavorite: map['is_favorite'] ?? false,
      attachmentUrl: map['attachment_url'],
      attachmentName: map['attachment_name'],
      attachmentType: map['attachment_type'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'category': category,
      'is_pinned': isPinned,
      'is_favorite': isFavorite,
      'attachment_url': attachmentUrl,
      'attachment_name': attachmentName,
      'attachment_type': attachmentType,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toInsertMap() {
    return {
      'user_id': userId,
      'title': title,
      'content': content,
      'category': category,
      'is_pinned': isPinned,
      'is_favorite': isFavorite,
      'attachment_url': attachmentUrl,
      'attachment_name': attachmentName,
      'attachment_type': attachmentType,
    };
  }

  NoteModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    String? category,
    bool? isPinned,
    bool? isFavorite,
    String? attachmentUrl,
    String? attachmentName,
    String? attachmentType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      isPinned: isPinned ?? this.isPinned,
      isFavorite: isFavorite ?? this.isFavorite,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      attachmentName: attachmentName ?? this.attachmentName,
      attachmentType: attachmentType ?? this.attachmentType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
