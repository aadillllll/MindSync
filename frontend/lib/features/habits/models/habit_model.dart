class HabitModel {
  final String id;
  final String userId;

  final String title;
  final String? description;

  final String icon;
  final String color;

  final List<String> frequencyDays;

  final int currentStreak;
  final int longestStreak;

  final bool isActive;

  final bool completedToday;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const HabitModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.icon,
    required this.color,
    required this.frequencyDays,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.isActive = true,
    this.completedToday = false,
    this.createdAt,
    this.updatedAt,
  });

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      description: map['description'],
      icon: map['icon'] ?? 'check_circle',
      color: map['color'] ?? '#8B5CF6',
      frequencyDays: List<String>.from(map['frequency_days'] ?? []),
      currentStreak: map['current_streak'] ?? 0,
      longestStreak: map['longest_streak'] ?? 0,
      isActive: map['is_active'] ?? true,
      completedToday: map['completed_today'] ?? false,
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
      'icon': icon,
      'color': color,
      'frequency_days': frequencyDays,
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      'is_active': isActive,
      'completed_today': completedToday,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toInsertMap() {
    return {
      'user_id': userId,
      'title': title,
      'description': description,
      'icon': icon,
      'color': color,
      'frequency_days': frequencyDays,
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      'is_active': isActive,
    };
  }

  HabitModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? icon,
    String? color,
    List<String>? frequencyDays,
    int? currentStreak,
    int? longestStreak,
    bool? isActive,
    bool? completedToday,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HabitModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      frequencyDays: frequencyDays ?? this.frequencyDays,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      isActive: isActive ?? this.isActive,
      completedToday: completedToday ?? this.completedToday,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
