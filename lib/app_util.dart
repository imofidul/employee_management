import 'dart:ui';

import 'package:intl/intl.dart';

class AppColor{
  static Color primaryColor=const Color(0xff1DA1F2);
  static Color colorOnPrimary=const Color(0xffffffff);
  static Color textFieldBorderColor=const Color(0xffe5e5e5);
  static Color textBottomSheetColor=const Color(0xff323238);
  static Color backgroundColor=const Color(0xfff2f2f2);
  static Color employeeListBackgroundColor=const Color(0xfff5f5f5);


}
class AppDimension{
  static double fabHeight=50;
  static double fabWidth=50;
  static double fabBorderRadius=8;

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


