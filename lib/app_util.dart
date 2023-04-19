import 'dart:ui';

import 'package:intl/intl.dart';

class AppColor{
  static Color primaryColor=const Color(0xff1DA1F2);
  static Color colorOnPrimary=const Color(0xffffffff);
  static Color textFieldBorderColor=const Color(0xffe5e5e5);
  static Color textBottomSheetColor=const Color(0xff323238);
  static Color backgroundColor=const Color(0xfff2f2f2);
  static Color employeeListBackgroundColor=const Color(0xfff5f5f5);
  static Color emptyScreenTextColor=const Color(0xff323238);
  static Color unselectedTextColor=const Color(0xff949C9E);
  static Color blackValueColor=const Color(0xff323238);




}
class AppDimension{
  static double fabHeight=50;
  static double fabWidth=50;
  static double fabBorderRadius=8;
  ///fonts
  static double fontSizeLarge=18;
  static double fontSizeMedium=16;
  static double fontSizeSmall=14;
  static double fabIconHeight=18;
  static FontWeight fontWeight400=FontWeight.w400;
  static FontWeight fontWeight500=FontWeight.w500;
}



class AppDateUtil{
  static String formatDate(DateTime dateTime)
  {
    DateFormat dateFormat=DateFormat("dd MMM yyyy");
    return dateFormat.format(dateTime);
  }
  ///Takes milliseconds and converts to date
  static String formatDateFromMillisecond(int dateTimeSecondsFrom,int dateTimeSecondsTo)
  {
    if(dateTimeSecondsFrom==0) {
      return "";
    }
    DateTime dateTimeFrom=DateTime.fromMillisecondsSinceEpoch(dateTimeSecondsFrom);
    DateFormat dateFormat=DateFormat("dd MMM yyyy");
    String fromFormatted= dateFormat.format(dateTimeFrom);
    if(dateTimeSecondsTo==0) {
      return fromFormatted;
    }

    DateTime dateTimeTo=DateTime.fromMillisecondsSinceEpoch(dateTimeSecondsTo);
    String toFormatted= dateFormat.format(dateTimeTo);
    return "$fromFormatted, $toFormatted";
  }

}

class AppText{
  static String textEmployeeList="Employee List";
  static String textNoEmployeeFound="No employee records found";
  static String textCurrentEmployee= "Current Employees";
  static String textPreviousEmployee="Previous employees";
  static String textSwipeLeftToDelete="Swipe left to delete";
  static String textAddEmployee="Add Employee Details";
  static String textEditEmployee="Edit Employee Details";
  static String textDeletedEmployee='Employee record has been deleted';
  static String textDeletedUndoEmployee='Undo';
  static String textHintName= "Employee Name";
  static String roleDefaultText="Select Role";
  static String selectRoleError="Please select a role for this employee";
  static String nameError="Please enter name of the employee";
  static String dateError="Employee start date can not smaller than end date";
  static String cancelBtnText="Cancel";
  static String confirmButtonText="Save";
  static String roleProductDesigner="Product Designer";
  static String roleFlutterDeveloper="Flutter Developer";
  static String roleQA="QA Tester";
  static String roleProductOwner="Product Owner";
  static String updateButtonText="Update";
  static String noDate="No date";


}
