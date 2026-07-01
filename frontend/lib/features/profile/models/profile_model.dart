class ProfileModel {
  final String id;

  final String? fullName;
  final String? username;
  final String? avatarUrl;

  final String? bio;
  final String? college;
  final String? course;
  final String? semester;

  final int productivityScore;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProfileModel({
    required this.id,
    this.fullName,
    this.username,
    this.avatarUrl,
    this.bio,
    this.college,
    this.course,
    this.semester,
    this.productivityScore = 0,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,

      fullName: map['full_name'] as String?,
      username: map['username'] as String?,
      avatarUrl: map['avatar_url'] as String?,

      bio: map['bio'] as String?,
      college: map['college'] as String?,
      course: map['course'] as String?,
      semester: map['semester'] as String?,

      productivityScore: map['productivity_score'] ?? 0,

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

      'full_name': fullName,
      'username': username,
      'avatar_url': avatarUrl,

      'bio': bio,
      'college': college,
      'course': course,
      'semester': semester,

      'productivity_score': productivityScore,

      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ProfileModel copyWith({
    String? fullName,
    String? username,
    String? avatarUrl,
    String? bio,
    String? college,
    String? course,
    String? semester,
    int? productivityScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileModel(
      id: id,

      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,

      bio: bio ?? this.bio,
      college: college ?? this.college,
      course: course ?? this.course,
      semester: semester ?? this.semester,

      productivityScore: productivityScore ?? this.productivityScore,

      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
