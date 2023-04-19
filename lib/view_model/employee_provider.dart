import 'package:employee_management/data/model/employee_modal.dart';
import 'package:employee_management/data/repository/employee_repository.dart';
import 'package:flutter/cupertino.dart';

///Provides employee data to UI and saved employee data changes in database
class EmployeeProvider extends ChangeNotifier{
  final EmployeeRepository _employeeRepository=EmployeeRepository();
  final List<EmployeeModal> _currentEmployees = [];
  List<EmployeeModal> get currentEmployees => _currentEmployees;
  final List<EmployeeModal> _previousEmployees = [];
  List<EmployeeModal> get previousEmployees => _previousEmployees;

  EmployeeProvider(){
    getEmployees();
  }

  ///Add Employee to data base
  Future addEmployee(EmployeeModal employee)async{
   await _employeeRepository.insertEmployee(employee);
   getEmployees();
    notifyListeners();
  }

  ///Removes employee from database based on employee id
  Future removeEmployee(EmployeeModal employee)async {
    _employeeRepository.deleteEmployeeRecord(employee);
    getEmployees();
    notifyListeners();
  }

  ///Updates a employee from database based on employee id
  Future updateEmployee(EmployeeModal employee)async{
    await _employeeRepository.updateEmployeeRecord(employee);
    getEmployees();
    notifyListeners();
  }


  ///Get All Employees from database
  void getEmployees() async{
    List<Map<String, dynamic>>? data =await  _employeeRepository.getEmployees();
    ///Clear previous data to avoid duplication in UI
    currentEmployees.clear();
    previousEmployees.clear();
    ///Employee data exist
    if(data!=null&&data.isNotEmpty)
      {
        for (var element in data) {
          EmployeeModal employeeModal=EmployeeModal.fromJson(element);

          ///As employee toDate is not available so its a current employee
          bool isCurrentEmployee=employeeModal.employmentToDate==0;


          ///Employee toDate is available
          if(employeeModal.employmentToDate!=0) {
            DateTime employeeToDate= DateTime.fromMillisecondsSinceEpoch(employeeModal.employmentToDate??0);
            DateTime currentDateTime=DateTime.now();
            Duration duration =employeeToDate.difference(currentDateTime);


            ///Employee toDate is smaller than current date
            ///So its a past employee
            if(duration.isNegative) {
              isCurrentEmployee=false;
            }
            ///Employee toDate is greater than current date
            ///So its a present employee
            else{
              isCurrentEmployee=true;
            }
          }

          ///Add All present employee
          if(isCurrentEmployee) {
            currentEmployees.add(employeeModal);
          }
          ///Add all previous employees
          if(!isCurrentEmployee) {
            previousEmployees.add(employeeModal);
          }
        }
      }
    notifyListeners();
  }

}