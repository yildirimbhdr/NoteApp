import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: "WorkSans",
  scaffoldBackgroundColor: Color(0xff252525),
  iconTheme: IconThemeData(
    size: ScreenUtil().setSp(60),
    color: Colors.white,
  ),
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.all(10),
    minWidth: ScreenUtil().setWidth(50),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff252525),
  ),
  textTheme: TextTheme(
    headline2: TextStyle(
        color: Colors.white,
        fontSize: ScreenUtil().setSp(60),
        fontWeight: FontWeight.w500),
    headline1: TextStyle(
        color: Colors.white,
        fontSize: ScreenUtil().setSp(65),
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2),
    overline: TextStyle(
        color: Color(0xff686868),
        fontSize: ScreenUtil().setSp(25),
        fontWeight: FontWeight.w500),
    subtitle1: TextStyle(
        fontSize: ScreenUtil().setSp(40),
        fontWeight: FontWeight.w500,
        letterSpacing: 1),
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: ScreenUtil().setSp(30),
      wordSpacing: 1,
    ),
  ),
  hoverColor: Color(0xff3B3B3B),
  buttonColor: Color(0xff3B3B3B),
);
