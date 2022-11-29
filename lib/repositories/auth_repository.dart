import 'package:ceosi_app/repositories/auth_repository_interface.dart';
import 'package:ceosi_app/repositories/ceosi_company_app/employee_repository.dart';
import 'package:ceosi_app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthRepository implements AuthRepositoryInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<List<UserModel>?> loginOfuser(String email, password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);

    return null;
  }

  @override
  userSignUp(
    String name,
    email,
    password,
    confirmPassword,
    role,
    department,
    birthdate,
  ) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    final user = FirebaseAuth.instance.currentUser!;

    UserRepository().addUser(
      name,
      email,
      password,
      confirmPassword,
      role,
      user.uid,
      'https://cdn-icons-png.flaticon.com/512/3899/3899618.png',
    );

    EmployeeRepository().addEmployee(
      name,
      email,
      role,
      user.uid,
      department,
      birthdate,
      'https://cdn-icons-png.flaticon.com/512/1177/1177568.png',
    );
  }
}
