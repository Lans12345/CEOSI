import '../models/user_model.dart';

abstract class AuthRepositoryInterface {
  userSignUp(String name, email, password, confirmPassword, role, department,
      birthdate);

  Future<List<UserModel>?> loginOfuser(String email, password);
}
