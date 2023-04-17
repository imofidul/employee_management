import 'package:employee_management/data/database/app_database.dart';
import 'package:employee_management/data/model/employee_modal.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeRepository{
  ///Get Database Connection
  Future<Database?> _getDatabaseInstance()async{
    return await AppDatabase.instance.database;
  }
  void insertEmployee(EmployeeModal employee)async{
    Database? database=await _getDatabaseInstance();
    await database?.insert(AppDatabase.tableEmployee, employee.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<Map<String, dynamic>>?>getEmployees()async{
    Database? database=await _getDatabaseInstance();
    return await database?.query(AppDatabase.tableEmployee,);
  }
  Future<dynamic>updateEmployeeRecord(EmployeeModal employeeModal)async{
    Database? database=await _getDatabaseInstance();
    return await database?.update(AppDatabase.tableEmployee,employeeModal.toJson(),where: "id = ?",whereArgs: [employeeModal.id]);
  }
}