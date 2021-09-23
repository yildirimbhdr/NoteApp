import 'package:flutter/cupertino.dart';

class SizeConstant {
  static SizeConstant instance = SizeConstant._init();
  SizeConstant._init();
  final EdgeInsetsGeometry pagePadding =
      EdgeInsets.symmetric(horizontal: 25, vertical: 40);
  final BorderRadiusGeometry radius = BorderRadius.circular(12);
}
