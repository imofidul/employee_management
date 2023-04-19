import 'package:employee_management/app_util.dart';
import 'package:employee_management/data/model/employee_modal.dart';
import 'package:employee_management/view_model/employee_provider.dart';
import 'package:employee_management/widgets/app_custom_date_picker.dart';
import 'package:employee_management/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddOrUpdateEmployeeScreen extends StatefulWidget {
  final EmployeeModal? employeeModal;
  const AddOrUpdateEmployeeScreen({Key? key,this.employeeModal}) : super(key: key);

  @override
  State<AddOrUpdateEmployeeScreen> createState() => _AddOrUpdateEmployeeScreenState();
}

class _AddOrUpdateEmployeeScreenState extends State<AddOrUpdateEmployeeScreen> {

  final _formKey = GlobalKey<FormState>();
  String employmentToDateFormatted="";
  String employmentFromDateFormatted="";
  String employeeRoleSelected="";
  DateTime? employmentFromDate;
  DateTime? employmentToDate;
  final TextEditingController _controllerEmployeeName=TextEditingController();
  
  ///Pick a date from dialog
  Future<DateTime?> getDateTime()async{
    DateTime now = DateTime.now();
    DateTime firstDate =
    now.subtract(const Duration(days: 36500));
    DateTime lastDate =
    now.add(const Duration(days: 36500));

   /// [showDatePickerCustom] is custom dialog created from framework copied and edited
    DateTime? dateTime=await showDatePickerCustom(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
      confirmText: "SAVE",
      cancelText: "CANCEL"
    );



    if(dateTime!=null) {

      DateTime dateTimeCurrent=DateTime.now();
      Duration duration=dateTimeCurrent.difference(dateTime);
      ///Selected no date from Dialog
     if( (duration.inDays/365)>900){
       employmentToDate = null;
       employmentToDateFormatted = "";
       setState(() {

       });
       return null;
     }


    }

    return dateTime;
  }
  ///Set existing employee details if available
  void setEmployeeDetails(){
    ///Update and delete case
    if(widget.employeeModal!=null)
      {
        _controllerEmployeeName.text=widget.employeeModal?.name??"";

        ///Existing From date
        employmentFromDate=DateTime.fromMillisecondsSinceEpoch(widget.employeeModal?.employmentFromDate??0);
        if(employmentFromDate!=null) {
          employmentFromDateFormatted=AppDateUtil.formatDate(employmentFromDate!);
        }
        ///Existing to date
        int toDatePrevious= widget.employeeModal?.employmentToDate??0;

        ///Previous to date is available
        if(toDatePrevious!=0) {
          employmentToDate=DateTime.fromMillisecondsSinceEpoch(widget.employeeModal?.employmentToDate??0);
          employmentToDateFormatted=AppDateUtil.formatDate(employmentToDate!);
        }
        employeeRoleSelected=widget.employeeModal?.role??"";

        ///Refresh UI
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
        automaticallyImplyLeading: false,
        title:  Text(widget.employeeModal==null?AppText.textAddEmployee:AppText.textEditEmployee,style: headerTextStyle),
        actions: [
          if(widget.employeeModal!=null)
            GestureDetector(
              onTap: ()async{
                final snackBar = SnackBar(
                  content:  Text(AppText.textDeletedEmployee),
                  action: SnackBarAction(
                    label: AppText.textDeletedUndoEmployee,
                    onPressed: () {
                       Provider.of<EmployeeProvider>(context, listen: false).addEmployee(widget.employeeModal!);
                    },
                  ),
                );
                await Provider.of<EmployeeProvider>(context, listen: false).removeEmployee(widget.employeeModal!);
                if(mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if(mounted) {
                  Future.delayed(const Duration(seconds: 4),(){
                    Navigator.pop(context);
                  });
                }
              },
              child:  Padding(
                padding: const EdgeInsets.all(21.62),
                child:  SvgPicture.asset(
                    "./assets/svg/delete_icon.svg"),
              ),
            ),
        ],
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
                    controller: _controllerEmployeeName,
                    style:formValueTextStyleMedium,
                    decoration: InputDecoration(
                      hintText:AppText.textHintName,
                      hintStyle: unSelectedTextStyleMedium,
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
                                    Navigator.pop(context,AppText.roleProductDesigner);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,bottom: 8),
                                    child: Text(AppText.roleProductDesigner,style: bottomSheetTextStyle,),
                                  ),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context,AppText.roleFlutterDeveloper);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,bottom: 8),
                                    child: Text(AppText.roleFlutterDeveloper,style: bottomSheetTextStyle,),
                                  ),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context,AppText.roleQA);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,bottom: 8),
                                    child: Text(AppText.roleQA,style: bottomSheetTextStyle,),
                                  ),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context,AppText.roleProductOwner);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16,bottom: 8),
                                    child: Text(AppText.roleProductOwner,style: bottomSheetTextStyle,),
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
                         employeeRoleSelected=role;
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
                            employeeRoleSelected.isEmpty?
                            AppText.roleDefaultText:employeeRoleSelected,
                            style: employeeRoleSelected.isEmpty?unSelectedTextStyleMedium:formValueTextStyleMedium,
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
                          employmentFromDate=await getDateTime();
                          if(employmentFromDate!=null) {
                            employmentFromDateFormatted=AppDateUtil.formatDate(employmentFromDate!);
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
                               Flexible(child: Text(employmentFromDateFormatted.isEmpty?"Today":employmentFromDateFormatted,style:formValueStyleSmall)),
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
                          employmentToDate=await getDateTime();
                          if(employmentToDate!=null) {
                            employmentToDateFormatted=AppDateUtil.formatDate(employmentToDate!);
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
                              Flexible(child: Text(employmentToDateFormatted.isEmpty?AppText.noDate:employmentToDateFormatted,style: employmentToDateFormatted.isEmpty?unselectedStyleSmall:formValueStyleSmall,)),
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
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffEDF8FF),
            ),
            child: Text(
              AppText.cancelBtnText,
              style: GoogleFonts.roboto(color: AppColor.primaryColor),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          ElevatedButton(onPressed: () async{

               if(employeeRoleSelected.isEmpty) {
                 Fluttertoast.showToast(msg: AppText.selectRoleError);
                 return;
               }
               if(_controllerEmployeeName.text.isEmpty) {
                 Fluttertoast.showToast(msg: AppText.nameError);
                 return;
               }
               if(employmentToDate!=null&&employmentFromDate!=null)
                 {
                   Duration diff =employmentToDate!.difference(employmentFromDate!);
                   if(diff.isNegative) {
                     Fluttertoast.showToast(msg: AppText.dateError);
                     return;
                   }
                 }


               saveOrUpdateEmployee();


          }, child:  Text(widget.employeeModal==null?AppText.confirmButtonText:AppText.updateButtonText))
        ],
      ),
    );
  }
  ///Insert or Updates employee
  void saveOrUpdateEmployee()async{
    EmployeeModal employeeModal=EmployeeModal();

    ///Employee update case
    if(widget.employeeModal!=null) {
      employeeModal=widget.employeeModal!;
    }


    employeeModal.role=employeeRoleSelected;

    ///if employment from date is not available just put today
    employeeModal.employmentFromDate=employmentFromDate?.millisecondsSinceEpoch??DateTime.now().millisecondsSinceEpoch;

    ///If to Date is not available just put 0
    employeeModal.employmentToDate=employmentToDate?.millisecondsSinceEpoch??0;
    employeeModal.name=_controllerEmployeeName.text;

    ///Update
    if(widget.employeeModal!=null) {
      await Provider.of<EmployeeProvider>(context, listen: false).updateEmployee(employeeModal);
    }
    ///Insert
    if(widget.employeeModal==null&&mounted) {
      await Provider.of<EmployeeProvider>(context, listen: false).addEmployee(employeeModal);
    }
    if(mounted) {
      Navigator.pop(context);
    }
  }
}
