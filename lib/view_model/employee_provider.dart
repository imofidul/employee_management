import 'package:employee_management/data/model/employee_modal.dart';
import 'package:flutter/cupertino.dart';

class EmployeeProvider extends ChangeNotifier{
  List<EmployeeModal> _employeeList = [];
  List<EmployeeModal> get employeeList => _employeeList;
  set employeeList(List<EmployeeModal> value) {
    _employeeList = value;
    notifyListeners();
  }

  void addEmployee(EmployeeModal employee){
    _employeeList.add(employee);
    notifyListeners();
  }

  void removeEmployee(EmployeeModal employee){
    _employeeList.remove(employee);
    notifyListeners();
  }

  void updateEmployee(EmployeeModal employee){

    notifyListeners();
  }

  void clearEmployeeList(){
    _employeeList.clear();
    notifyListeners();
  }

}