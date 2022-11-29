import 'package:ceosi_app/repositories/ceosi_company_app/employee_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeRepository implements EmployeeRepositoryInterface {
  @override
  Future addEmployee(String fullName, email, role, uid, department, birthdate,
      profileImage) async {
    final docEmployee = FirebaseFirestore.instance
        .collection('CEOSI-COMPANYAPP-EMPLOYEE')
        .doc();

    final docEmployeeList = FirebaseFirestore.instance
        .collection('CEOSI-COMPANYAPP-EMPLOYEELIST')
        .doc();

    final jsonEmployee = {
      'id': docEmployee.id,
      'user_id': uid,
      'name': fullName,
      'email': email,
      'profile_image': profileImage,
      'department': department,
      'birthdate': birthdate,
      'position': role,
      'user_points': 0,
      'contributions': 0,
    };
    final jsonEmployeeList = {
      'id': docEmployeeList.id,
      'user_id': uid,
      'name': fullName,
      'email': email,
      'profile_image': profileImage,
      'position': role,
      // 'user_points': 0,
      // 'contributions': 0,
    };

    await docEmployee.set(jsonEmployee);
    await docEmployeeList.set(jsonEmployeeList);
  }
}
