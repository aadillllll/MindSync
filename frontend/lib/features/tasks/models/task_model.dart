class TaskModel {
  final String id;
  final String userId;

  final String title;
  final String? description;

  final String? priority;
  final String? status;

  final bool isCompleted;

  final DateTime? dueDate;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.priority,
    this.status,
    this.isCompleted = false,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      status: map['status'],
      isCompleted: map['is_completed'] ?? false,
      dueDate: map['due_date'] != null ? DateTime.parse(map['due_date']) : null,
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
      'description': description,
      'priority': priority,
      'status': status,
      'is_completed': isCompleted,
      'due_date': dueDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toInsertMap() {
    return {
      'user_id': userId,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'is_completed': isCompleted,
      'due_date': dueDate?.toIso8601String(),
    };
  }

  TaskModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? priority,
    String? status,
    bool? isCompleted,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get completed => isCompleted;

  bool get isPending => !isCompleted;

  bool get isHighPriority => priority?.toLowerCase() == 'high';

  bool get isMediumPriority => priority?.toLowerCase() == 'medium';

  bool get isLowPriority => priority?.toLowerCase() == 'low';
}
