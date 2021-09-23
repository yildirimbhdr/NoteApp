import 'package:flutter/material.dart';
import 'package:notes_app/core/constant/size_constant.dart';
import 'package:notes_app/core/models/note.dart';
import 'package:notes_app/view/note_add_page.dart';
import 'package:notes_app/view/shared/buttons/container_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/core/init/extension/date_time_extension.dart';

class NoteDetailPage extends StatefulWidget {
  Note note;
  NoteDetailPage({Key? key, required this.note}) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: SizeConstant.instance.pagePadding,
        children: [
          title(context),
          space,
          Container(
            child: Text(widget.note.title ?? "",
                style: Theme.of(context).textTheme.headline1),
          ),
          space,
          Text(
            widget.note.created!.convertFrontEnd(),
            style: Theme.of(context).textTheme.overline,
          ),
          space,
          Text(widget.note.description ?? "",
              style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }

  Widget title(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerButton(
            icon: Icons.arrow_back,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ContainerButton(
            icon: Icons.edit,
            onTap: () async {
              Note? _note = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteAddPage(
                    note: widget.note,
                  ),
                ),
              );
              print(_note?.title);
              if (_note != null) {
                setState(() {
                  widget.note = _note;
                });
              }
            },
          )
        ],
      );

  Widget get space => SizedBox(
        height: ScreenUtil().setHeight(25),
      );
}
