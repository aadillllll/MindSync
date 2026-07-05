class GoalModel {
  final String id;
  final String userId;

  final String title;
  final String? description;

  final int target;
  final int progress;

  final DateTime? deadline;

  final bool completed;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const GoalModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.target,
    this.progress = 0,
    this.deadline,
    this.completed = false,
    this.createdAt,
    this.updatedAt,
  });

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      description: map['description'],
      target: map['target'] ?? 0,
      progress: map['progress'] ?? 0,
      deadline: map['deadline'] != null
          ? DateTime.parse(map['deadline'])
          : null,
      completed: map['completed'] ?? false,
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
      'target': target,
      'progress': progress,
      'deadline': deadline?.toIso8601String(),
      'completed': completed,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toInsertMap() {
    return {
      'user_id': userId,
      'title': title,
      'description': description,
      'target': target,
      'progress': progress,
      'deadline': deadline?.toIso8601String(),
      'completed': completed,
    };
  }

  GoalModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    int? target,
    int? progress,
    DateTime? deadline,
    bool? completed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GoalModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      target: target ?? this.target,
      progress: progress ?? this.progress,
      deadline: deadline ?? this.deadline,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  double get progressValue {
    if (target == 0) return 0;
    return progress / target;
  }

  int get progressPercentage => (progressValue.clamp(0.0, 1.0) * 100).round();

  bool get isCompleted => completed;
}
