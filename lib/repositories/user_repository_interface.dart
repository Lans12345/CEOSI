abstract class UsertRepositoryInterface {
  Future addUser(String fullName, String email, String password,
      String confirmPassword, String role, String uid, String profileImage);
}
