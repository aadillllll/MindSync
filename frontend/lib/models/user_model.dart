class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final int productivityScore;
  final int streak;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.productivityScore = 0,
    this.streak = 0,
  });

  // Demo user (temporary until authentication is added)
  static const demo = UserModel(
    id: "1",
    name: "Adill",
    email: "adill@example.com",
    profileImage: "assets/images/profile.png",
    productivityScore: 84,
    streak: 12,
  );
}
