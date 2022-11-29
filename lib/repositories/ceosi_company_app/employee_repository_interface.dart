abstract class EmployeeRepositoryInterface {
  Future addEmployee(
      String fullName, email, role, uid, department, birthdate, profileImage);
}
