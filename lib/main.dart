import 'package:employee_management/screen/home_screen.dart';
import 'package:employee_management/view_model/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'app_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmployeeProvider()),
      ],
      child:MaterialApp(
        theme: ThemeData(
            primaryColor: AppColor.primaryColor,
            textTheme: GoogleFonts.robotoTextTheme()
        ),
        home: const HomeScreen(),
      ),
    );

  }
}


