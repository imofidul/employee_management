import 'package:employee_management/app_util.dart';
import 'package:employee_management/data/model/employee_modal.dart';
import 'package:employee_management/views/add_employee_screen.dart';
import 'package:employee_management/widgets/text_style.dart';
import 'package:flutter/material.dart';

class EmployeeItem extends StatelessWidget {
  final EmployeeModal employeeModal;
  const EmployeeItem({Key? key,required this.employeeModal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(employeeModal.name??"",style: h1TextStyle,),
          Text(employeeModal.role??"",style: h2TextStyle,),
          Text(AppDateUtil.formatDateFromMillisecond(employeeModal.employmentFromDate??0,employeeModal.employmentToDate??0,),style: h2TextStyle),
        ],
      ),
    );
  }
}
