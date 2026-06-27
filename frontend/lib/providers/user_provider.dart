import '../models/user_model.dart';

class UserProvider {
  static final UserModel currentUser = UserModel(
    id: "1",
    name: "Adil",
    email: "adil@example.com",
    productivityScore: 82,
    streak: 14,
  );
}
