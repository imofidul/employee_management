import 'dart:ui';

import 'package:intl/intl.dart';

class AppColor{
  static Color primaryColor=const Color(0xff1DA1F2);
  static Color colorOnPrimary=const Color(0xffffffff);
  static Color textFieldBorderColor=const Color(0xffe5e5e5);
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
}


