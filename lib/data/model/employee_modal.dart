class EmployeeModal{
  String? name;
  String? role;
  int? dateFrom;
  int? dateTo;
  int ?id;

  EmployeeModal({this.name, this.role, this.dateFrom, this.dateTo});

  EmployeeModal.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    role = json?['role'];
    dateFrom = json?['dateFrom'];
    dateTo = json?['dateTo'];
    id=json?['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['role'] = role;
    data['dateFrom'] = dateFrom;
    data['dateTo'] = dateTo;
    data['id']=id;
    return data;
  }
}