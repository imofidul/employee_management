import 'package:employee_management/app_util.dart';
import 'package:employee_management/data/model/employee_modal.dart';
import 'package:employee_management/view_model/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddEmployeeScreen extends StatefulWidget {
  final EmployeeModal? employeeModal;
  const AddEmployeeScreen({Key? key,this.employeeModal}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  String toDateFormatted="";
  String fromDateFormatted="";
  String roleSelected="";
  DateTime? fromDate;
  DateTime? toDate;
  final TextEditingController _controllerName=TextEditingController();
  
  ///Pick a date from dialog
  Future<DateTime?> getDateTime()async{
    DateTime now = DateTime.now();
    DateTime firstDate =
    now.subtract(const Duration(days: 3650));
    DateTime lastDate =
    now.add(const Duration(days: 3650));
    DateTime? dateTime=await  showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );
    return dateTime;
  }
  void setEmployeeDetails(){
    ///Update and delete case
    if(widget.employeeModal!=null)
      {
        _controllerName.text=widget.employeeModal?.name??"";

        ///Existing From date
        fromDate=DateTime.fromMillisecondsSinceEpoch(widget.employeeModal?.dateFrom??0);
        if(fromDate!=null) {
          fromDateFormatted=AppDateUtil.formatDate(fromDate!);
        }

        ///Existing to date
        int toDatePrevious= widget.employeeModal?.dateTo??0;
        if(toDatePrevious!=0) {
          toDate=DateTime.fromMillisecondsSinceEpoch(widget.employeeModal?.dateTo??0);
          toDateFormatted=AppDateUtil.formatDate(toDate!);
        }

        roleSelected=widget.employeeModal?.role??"";
        setState(() {

        });

      }
  }
  @override
  void initState() {
    setEmployeeDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee Details"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            child: Column(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.textFieldBorderColor)),
                  child: TextFormField(
                    controller: _controllerName,
                    decoration: InputDecoration(
                      hintText: "Joseph Manadan",
                      icon: Padding(
                        padding: const EdgeInsets.only(
                            top: 12.69, bottom: 12.69, left: 12.69),
                        child: Image.asset("./assets/png/avatar.png"),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                GestureDetector(
                  onTap: ()async{
                   String? role= await showModalBottomSheet<String?>(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                      ),
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 208,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                  onTap:(){
                                    Navigator.pop(context,"Product Designer");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,bottom: 8),
                                    child: Text("Product Designer",style: GoogleFonts.roboto(fontSize: 16,color: AppColor.textBottomSheetColor),),
                                  ),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context,"Flutter Developer");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,bottom: 8),
                                    child: Text("Flutter Developer",style: GoogleFonts.roboto(fontSize: 16,color: AppColor.textBottomSheetColor),),
                                  ),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context,"QA Tester");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,bottom: 8),
                                    child: Text("QA Tester",style: GoogleFonts.roboto(fontSize: 16,color: AppColor.textBottomSheetColor),),
                                  ),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context,"Product Owner");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,bottom: 8),
                                    child: Text("Product Owner",style: GoogleFonts.roboto(fontSize: 16,color: AppColor.textBottomSheetColor),),
                                  ),
                                ),


                              ],
                            ),
                          ),
                        );
                      }, context: context,
                    );
                   if(role!=null)
                     {
                       setState(() {
                         roleSelected=role;
                       });
                     }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.textFieldBorderColor)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12.69,
                              bottom: 12.69,
                              left: 12.69,
                              right: 14.5),
                          child: Image.asset("./assets/png/role.png"),
                        ),
                         Expanded(
                          child: Text(
                            roleSelected.isEmpty?
                            "Select Role":roleSelected,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.79),
                          child: SvgPicture.asset(
                              "./assets/svg/role_drop_down_icon.svg"),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: ()async{
                          fromDate=await getDateTime();
                          if(fromDate!=null) {
                            fromDateFormatted=AppDateUtil.formatDate(fromDate!);
                            setState(() {
                            });
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColor.textFieldBorderColor),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 11.5, right: 13.18),
                                child: SvgPicture.asset(
                                    "./assets/svg/calender_icon.svg"),
                              ),
                               Text(fromDateFormatted.isEmpty?"Today":fromDateFormatted),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(19.19),
                      child: SvgPicture.asset("./assets/svg/arrow_forward.svg"),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: ()async{
                          toDate=await getDateTime();
                          if(toDate!=null) {
                            toDateFormatted=AppDateUtil.formatDate(toDate!);
                            setState(() {

                            });
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColor.textFieldBorderColor),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 11.5, right: 13.18),
                                child: SvgPicture.asset(
                                    "./assets/svg/calender_icon.svg"),
                              ),
                              Text(toDateFormatted.isEmpty?"No date":toDateFormatted),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        children: [
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffEDF8FF),
            ),
            child: Text(
              "Cancel",
              style: GoogleFonts.roboto(color: AppColor.primaryColor),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          ElevatedButton(onPressed: () async{

               if(roleSelected.isEmpty) {
                 Fluttertoast.showToast(msg: "Please select a role for this employee");
                 return;
               }
               if(_controllerName.text.isEmpty) {
                 Fluttertoast.showToast(msg: "Please select a role for this employee");
                 return;
               }

               saveEmployee();


          }, child: const Text("Save"))
        ],
      ),
    );
  }
  void saveEmployee()async{
    EmployeeModal employeeModal=EmployeeModal();

    if(widget.employeeModal!=null) {
      employeeModal=widget.employeeModal!;
    }


    employeeModal.role=roleSelected;
    employeeModal.dateFrom=fromDate?.millisecondsSinceEpoch??DateTime.now().millisecondsSinceEpoch;
    employeeModal.dateTo=toDate?.millisecondsSinceEpoch??0;
    employeeModal.name=_controllerName.text;
    if(widget.employeeModal!=null) {
      await Provider.of<EmployeeProvider>(context, listen: false).updateEmployee(employeeModal);
    }
    if(widget.employeeModal==null&&mounted) {
      await Provider.of<EmployeeProvider>(context, listen: false).addEmployee(employeeModal);
    }
    if(mounted) {
      Navigator.pop(context);
    }
  }
}
