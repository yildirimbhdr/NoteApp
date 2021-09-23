import 'package:flutter/material.dart';
import 'package:notes_app/core/init/dark_theme.dart';
import 'package:notes_app/view/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        title: 'Note Save',
        home: HomePage(),
      ),
      designSize: Size(750, 1334),
    );
  }
}
