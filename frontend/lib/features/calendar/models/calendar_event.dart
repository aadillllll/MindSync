class CalendarEvent {
  final String id;
  final String userId;

  final String title;
  final String? description;

  final String category;
  final String? location;
  final String color;

  final DateTime startDateTime;
  final DateTime endDateTime;

  final bool isAllDay;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CalendarEvent({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.category,
    this.location,
    required this.color,
    required this.startDateTime,
    required this.endDateTime,
    this.isAllDay = false,
    this.createdAt,
    this.updatedAt,
  });

  factory CalendarEvent.fromMap(Map<String, dynamic> map) {
    return CalendarEvent(
      id: map['id'],
      userId: map['user_id'],

      title: map['title'],
      description: map['description'],

      category: map['category'] ?? 'Personal',
      location: map['location'],

      color: map['color'] ?? 'blue',

      startDateTime: DateTime.parse(map['start_datetime']),
      endDateTime: DateTime.parse(map['end_datetime']),

      isAllDay: map['is_all_day'] ?? false,

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

      'category': category,
      'location': location,

      'color': color,

      'start_datetime': startDateTime.toIso8601String(),
      'end_datetime': endDateTime.toIso8601String(),

      'is_all_day': isAllDay,

      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toInsertMap() {
    return {
      'user_id': userId,

      'title': title,
      'description': description,

      'category': category,
      'location': location,

      'color': color,

      'start_datetime': startDateTime.toIso8601String(),
      'end_datetime': endDateTime.toIso8601String(),

      'is_all_day': isAllDay,
    };
  }

  CalendarEvent copyWith({
    String? id,
    String? userId,

    String? title,
    String? description,

    String? category,
    String? location,

    String? color,

    DateTime? startDateTime,
    DateTime? endDateTime,

    bool? isAllDay,

    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      userId: userId ?? this.userId,

      title: title ?? this.title,
      description: description ?? this.description,

      category: category ?? this.category,
      location: location ?? this.location,

      color: color ?? this.color,

      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,

      isAllDay: isAllDay ?? this.isAllDay,

      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // =========================================================
  // Helper Getters
  // =========================================================

  Duration get duration => endDateTime.difference(startDateTime);

  bool get isToday {
    final now = DateTime.now();

    return startDateTime.year == now.year &&
        startDateTime.month == now.month &&
        startDateTime.day == now.day;
  }

  bool get isUpcoming => startDateTime.isAfter(DateTime.now());

  bool get isPast => endDateTime.isBefore(DateTime.now());

  bool get isOngoing {
    final now = DateTime.now();

    return now.isAfter(startDateTime) && now.isBefore(endDateTime);
  }
}
