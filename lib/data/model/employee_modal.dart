class EmployeeModal{
  String? name;
  String? role;
  int? employmentFromDate;
  int? employmentToDate;
  int ?employeeId;

  EmployeeModal({this.name, this.role, this.employmentFromDate, this.employmentToDate});

  EmployeeModal.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    role = json?['role'];
    employmentFromDate = json?['dateFrom'];
    employmentToDate = json?['dateTo'];
    employeeId=json?['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['role'] = role;
    data['dateFrom'] = employmentFromDate;
    data['dateTo'] = employmentToDate;
    data['id']=employeeId;
    return data;
  }
}