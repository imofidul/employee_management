import 'package:employee_management/app_util.dart';
import 'package:employee_management/data/model/employee_modal.dart';
import 'package:employee_management/views/add_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeItem extends StatelessWidget {
  final EmployeeModal employeeModal;
  const EmployeeItem({Key? key,required this.employeeModal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=> AddOrUpdateEmployeeScreen(employeeModal: employeeModal,)));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16,bottom: 16),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(employeeModal.name??"",style: GoogleFonts.roboto(color: const Color(0xff323238),fontSize: 16),),
            Text(employeeModal.role??"",style: GoogleFonts.roboto(color: const Color(0xff949C9E),fontSize: 14),),
            Text(AppDateUtil.formatDateFromMillisecond(employeeModal.employmentFromDate??0,employeeModal.employmentToDate??0,),style: GoogleFonts.roboto(color: const Color(0xff949C9E),fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
