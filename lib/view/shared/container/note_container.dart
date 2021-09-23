import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/core/constant/size_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/core/models/note.dart';
import 'package:notes_app/core/init/extension/date_time_extension.dart';

class NoteContainer extends StatefulWidget {
  final Note note;
  NoteContainer({Key? key, required this.note}) : super(key: key);

  @override
  _NoteContainerState createState() => _NoteContainerState();
}

class _NoteContainerState extends State<NoteContainer> {
  late Color _color;
  List<Color> colors = [
    Color(0xffFFAB91),
    Color(0xffFFCC80),
    Color(0xffE7ED9B),
    Color(0xffCF94DA),
    Color(0xff81DEEA),
  ];

  @override
  void initState() {
    super.initState();
    _color = colors[Random().nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: ScreenUtil().setWidth(500)),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: _color, borderRadius: SizeConstant.instance.radius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.note.title ?? "",
              style: Theme.of(context).textTheme.subtitle1),
          space,
          Text(widget.note.created!.convertFrontEnd(),
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.overline),
        ],
      ),
    );
  }

  Widget get space => SizedBox(
        height: ScreenUtil().setHeight(25),
      );
}
