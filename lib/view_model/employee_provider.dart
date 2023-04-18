import 'package:employee_management/data/model/employee_modal.dart';
import 'package:employee_management/data/repository/employee_repository.dart';
import 'package:flutter/cupertino.dart';

class EmployeeProvider extends ChangeNotifier{
  final EmployeeRepository _employeeRepository=EmployeeRepository();
  final List<EmployeeModal> _employeeListCurrent = [];
  List<EmployeeModal> get employeeListCurrent => _employeeListCurrent;
  final List<EmployeeModal> _employeeListPrevious = [];
  List<EmployeeModal> get employeeListPrevious => _employeeListPrevious;
  EmployeeProvider(){
    getEmployees();
  }

  Future addEmployee(EmployeeModal employee)async{
   await _employeeRepository.insertEmployee(employee);
   getEmployees();
    notifyListeners();
  }

  void removeEmployee(EmployeeModal employee){
    _employeeRepository.deleteEmployeeRecord(employee);
    getEmployees();
    notifyListeners();
  }

  void updateEmployee(EmployeeModal employee)async{
    await _employeeRepository.updateEmployeeRecord(employee);
    getEmployees();
    notifyListeners();
  }

  void clearEmployeeList(){
    notifyListeners();
  }

  ///Get All Employees from database
  void getEmployees() async{
    List<Map<String, dynamic>>? data =await  _employeeRepository.getEmployees();
    employeeListCurrent.clear();
    employeeListPrevious.clear();
    if(data!=null&&data.isNotEmpty)
      {
        for (var element in data) {
          EmployeeModal employeeModal=EmployeeModal.fromJson(element);
          if(employeeModal.dateTo==0) {
            employeeListCurrent.add(employeeModal);
          }
          if(employeeModal.dateTo!=0) {
            employeeListPrevious.add(employeeModal);
          }
        }
      }
    notifyListeners();
  }

}