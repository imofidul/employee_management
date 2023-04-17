import 'package:employee_management/app_util.dart';
import 'package:employee_management/data/model/employee_modal.dart';
import 'package:employee_management/data/repository/employee_repository.dart';
import 'package:employee_management/view_model/employee_provider.dart';
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
    //EmployeeRepository().insertEmployee(EmployeeModal(name: "Mofidul",role: "mndmv",dateFrom: 1681748997938,dateTo: 1681748997938));
   getData();

  }
  void getData()async{
    List<Map<String, dynamic>>? data =await EmployeeRepository().getEmployees();
    EmployeeModal employeeModal=EmployeeModal.fromJson(data?.first);
    employeeModal.name="Updatedname";
    await EmployeeRepository().updateEmployeeRecord(employeeModal);

    print(data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Employee List"),
        ),
        body: Consumer<EmployeeProvider>(
          builder: (_, employeeProvider, child) {
            if(employeeProvider.employeeList.isEmpty) {
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

            return const Text("Employees found");
          },
        ),
        floatingActionButton: Container(
          height: AppDimension.fabHeight,
          width: AppDimension.fabWidth,
          decoration: BoxDecoration(color: AppColor.primaryColor,borderRadius:  BorderRadius.all(Radius.circular(AppDimension.fabBorderRadius))),
          child: Icon(Icons.add,color: AppColor.colorOnPrimary,),),
    );

  }
}
