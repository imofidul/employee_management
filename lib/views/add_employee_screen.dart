import 'package:employee_management/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

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
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.textFieldBorderColor)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12.69, bottom: 12.69, left: 12.69,right: 14.5),
                        child: Image.asset("./assets/png/role.png"),
                      ),
                      const Expanded(
                        child: Text(
                         "Select Role",
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
                const SizedBox(
                  height: 23,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.textFieldBorderColor),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 11.5,right: 13.18),
                              child: SvgPicture.asset("./assets/svg/calender_icon.svg"),
                            ),
                            const Text("Today"),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(19.19),
                      child: SvgPicture.asset("./assets/svg/arrow_forward.svg"),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.textFieldBorderColor),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 11.5,right: 13.18),
                              child: SvgPicture.asset("./assets/svg/calender_icon.svg"),
                            ),
                            const Text("No date"),
                          ],
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
          ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffEDF8FF),), child:  Text("Cancel",style: GoogleFonts.roboto(color: AppColor.primaryColor),),),
          const SizedBox(width: 16,),
          ElevatedButton(onPressed: (){}, child: const Text("Save"))
        ],
      ),
    );
  }
}
