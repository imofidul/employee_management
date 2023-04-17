import 'package:employee_management/data/model/employee_modal.dart';
import 'package:flutter/cupertino.dart';

class EmployeeProvider extends ChangeNotifier{
  List<Employee> _employeeList = [];
  List<Employee> get employeeList => _employeeList;
  set employeeList(List<Employee> value) {
    _employeeList = value;
    notifyListeners();
  }

  void addEmployee(Employee employee){
    _employeeList.add(employee);
    notifyListeners();
  }

  void removeEmployee(Employee employee){
    _employeeList.remove(employee);
    notifyListeners();
  }

  void updateEmployee(Employee employee){

    notifyListeners();
  }

  void clearEmployeeList(){
    _employeeList.clear();
    notifyListeners();
  }

}