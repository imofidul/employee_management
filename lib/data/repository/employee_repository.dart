import 'package:employee_management/data/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeRepository{
  ///Get Database Connection
  Future<Database?> _getDatabaseInstance()async{
    return await AppDatabase.instance.database;
  }
  void insertEmployee()async{
    Database? database=await _getDatabaseInstance();
    await database?.insert(AppDatabase.tableEmployee, {},conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<dynamic>getEmployees()async{
    Database? database=await _getDatabaseInstance();
    return await database?.query(AppDatabase.tableEmployee,);
  }
  Future<dynamic>updateEmployeeRecord()async{
    Database? database=await _getDatabaseInstance();
    return await database?.update(AppDatabase.tableEmployee,{},where: "id",whereArgs: [1]);
  }
}