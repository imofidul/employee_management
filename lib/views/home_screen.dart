import 'package:employee_management/app_util.dart';
import 'package:employee_management/data/model/employee_modal.dart';
import 'package:employee_management/view_model/employee_provider.dart';
import 'package:employee_management/views/add_employee_screen.dart';
import 'package:employee_management/widgets/item_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
        title: const Text("Employee List"),
      ),
      body: Consumer<EmployeeProvider>(
        builder: (_, employeeProvider, child) {
          if (employeeProvider.employeeListCurrent.isEmpty &&
              employeeProvider.employeeListPrevious.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    "./assets/svg/empty_employee_list.svg",
                  ),
                ),
                const Text("No employee records found"),
              ],
            );
          }

          return Container(
            color: const Color(0xfff2f2f2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(employeeProvider.employeeListCurrent.isNotEmpty)
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Current Employees",
                          style:
                              GoogleFonts.roboto(color: AppColor.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
                if(employeeProvider.employeeListCurrent.isNotEmpty)
                Expanded(
                    child: Container(
                  color: const Color(0xfff5f5f5),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.separated(
                      itemCount: employeeProvider.employeeListCurrent.length,
                      itemBuilder: (_, index) {
                        EmployeeModal employee =
                            employeeProvider.employeeListCurrent[index];
                        return Dismissible(
                          direction:DismissDirection.endToStart,
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
                              employeeProvider.employeeListCurrent
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
                )),
                if(employeeProvider.employeeListPrevious.isNotEmpty)
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Previous employees",
                          style:
                              GoogleFonts.roboto(color: AppColor.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
                if(employeeProvider.employeeListPrevious.isNotEmpty)
                Expanded(
                  child: Container(
                    color: const Color(0xfff5f5f5),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.separated(
                          itemCount:
                              employeeProvider.employeeListPrevious.length,
                          itemBuilder: (_, index) {
                            EmployeeModal employee =
                                employeeProvider.employeeListPrevious[index];
                            return Dismissible(
                              direction:DismissDirection.endToStart,
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
                                  employeeProvider.employeeListPrevious
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 16),
                  child: Text(
                    "Swipe left to delete",
                    style: GoogleFonts.roboto(
                        fontSize: 14, color: const Color(0xff949C9E)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddEmployeeScreen()));
        },
        child: Container(
          height: AppDimension.fabHeight,
          width: AppDimension.fabWidth,
          decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.all(
                  Radius.circular(AppDimension.fabBorderRadius))),
          child: Icon(
            Icons.add,
            color: AppColor.colorOnPrimary,
          ),
        ),
      ),
    );
  }
}
