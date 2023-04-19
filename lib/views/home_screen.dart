import 'package:employee_management/app_util.dart';
import 'package:employee_management/data/model/employee_modal.dart';
import 'package:employee_management/view_model/employee_provider.dart';
import 'package:employee_management/views/add_employee_screen.dart';
import 'package:employee_management/widgets/item_employee.dart';
import 'package:employee_management/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

///Display list of employee or a empty screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Employee List",style: headerTextStyle,),
      ),
      body: Consumer<EmployeeProvider>(
        builder: (_, employeeProvider, child) {
          if (employeeProvider.currentEmployees.isEmpty &&
              employeeProvider.previousEmployees.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    "./assets/svg/empty_employee_list.svg",
                  ),
                ),
                 Text("No employee records found",style: GoogleFonts.roboto(color: AppColor.emptyScreenTextColor,fontWeight: AppDimension.fontWeight500,fontSize: AppDimension.fontSizeLarge,),),
              ],
            );
          }

          return Container(
            color: AppColor.backgroundColor,
            child: ListView(
              children: [
                if (employeeProvider.currentEmployees.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Current Employees",
                            style: subHeaderTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (employeeProvider.currentEmployees.isNotEmpty)
                  Container(
                    color: AppColor.employeeListBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: employeeProvider.currentEmployees.length,
                        itemBuilder: (_, index) {
                          EmployeeModal employee =
                              employeeProvider.currentEmployees[index];
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            key: ObjectKey(employee),
                            background: Container(
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (DismissDirection direction) {
                              if (direction == DismissDirection.endToStart) {
                                employeeProvider.currentEmployees
                                    .remove(employee);
                                employeeProvider.removeEmployee(employee);
                              }
                            },
                            child: EmployeeItem(
                              employeeModal: employee,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(height: 1);
                        },
                      ),
                    ),
                  ),
                if (employeeProvider.previousEmployees.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Previous employees",
                            style: subHeaderTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (employeeProvider.previousEmployees.isNotEmpty)
                  Container(
                    color: AppColor.employeeListBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              employeeProvider.previousEmployees.length,
                          itemBuilder: (_, index) {
                            EmployeeModal employee =
                                employeeProvider.previousEmployees[index];
                            return Dismissible(
                              direction: DismissDirection.endToStart,
                              key: ObjectKey(employee),
                              background: Container(
                                color: Colors.red,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (DismissDirection direction) {
                                if (direction == DismissDirection.endToStart) {
                                  employeeProvider.previousEmployees
                                      .remove(employee);
                                  employeeProvider.removeEmployee(employee);
                                }
                              },
                              child: EmployeeItem(
                                employeeModal: employee,
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(height: 1);
                          }),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 16),
                  child: Text(
                    "Swipe left to delete",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: const Color(0xff949C9E),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddOrUpdateEmployeeScreen(),
            ),
          );
        },
        child: Container(
          height: AppDimension.fabHeight,
          width: AppDimension.fabWidth,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimension.fabBorderRadius),
            ),
          ),
          child: Icon(
            Icons.add,
            color: AppColor.colorOnPrimary,
          ),
        ),
      ),
    );
  }
}
