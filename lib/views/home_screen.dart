import 'package:employee_management/app_util.dart';
import 'package:employee_management/data/model/employee_modal.dart';
import 'package:employee_management/view_model/employee_provider.dart';
import 'package:employee_management/views/add_employee_screen.dart';
import 'package:employee_management/widgets/item_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          if (employeeProvider.employeeListCurrent.isEmpty&&employeeProvider.employeeListPrevious.isEmpty) {
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

          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("Current Employee"),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: employeeProvider.employeeListCurrent.length,
                  itemBuilder: (_, index) {
                    EmployeeModal employee=employeeProvider.employeeListCurrent[index];
                   return Dismissible(
                    key: ObjectKey(employee),
                      background: Container(color: Colors.red),
                      onDismissed: (DismissDirection direction){
                      if(direction==DismissDirection.startToEnd) {
                        employeeProvider.employeeListCurrent.remove(employee);
                        employeeProvider.removeEmployee(employee);
                      }
                    },
                    child: EmployeeItem(
                      employeeModal: employee,
                    ),
                  );},
                ),
              )),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("Previous employees"),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                          itemCount:
                              employeeProvider.employeeListPrevious.length,
                          itemBuilder: (_, index) => EmployeeItem(
                              employeeModal: employeeProvider
                                  .employeeListPrevious[index]))))
            ],
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
