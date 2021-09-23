import 'package:flutter/material.dart';
import 'package:notes_app/core/constant/size_constant.dart';
import 'package:notes_app/core/models/note.dart';
import 'package:notes_app/core/services/sqflite_services.dart';
import 'package:notes_app/view/shared/buttons/container_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/core/init/extension/date_time_extension.dart';

class NoteAddPage extends StatefulWidget {
  final Note? note;
  const NoteAddPage({Key? key, this.note}) : super(key: key);

  @override
  _NoteAddPageState createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  TextEditingController _controllerTitle =
      TextEditingController(text: "New Note");
  TextEditingController _controllerDesc =
      TextEditingController(text: "Description");
  FocusNode _nodeTitle = FocusNode();
  FocusNode _nodeDesc = FocusNode();

  @override
  void initState() {
    super.initState();
    _nodeTitle.requestFocus();
    if (widget.note != null) {
      _controllerTitle.text = widget.note?.title ?? "";
      _controllerDesc.text = widget.note?.description ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (widget.note != null) {
          print("fadfas");
          Navigator.pop(context, widget.note);
        }
        Navigator.pop(context);
        return Future.value();
      },
      child: Scaffold(
        body: ListView(
          padding: SizeConstant.instance.pagePadding,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContainerButton(
                  icon: Icons.arrow_back,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ContainerButton(
                  icon: Icons.done,
                  onTap: () {
                    _saveNote();
                  },
                ),
              ],
            ),
            space,
            EditableText(
              backgroundCursorColor: Theme.of(context).hoverColor,
              controller: _controllerTitle,
              cursorColor: Theme.of(context).hoverColor,
              style: Theme.of(context).textTheme.headline2 ?? TextStyle(),
              focusNode: _nodeTitle,
            ),
            space,
            Text(
              DateTime.now().convertFrontEnd(),
              style: Theme.of(context).textTheme.overline,
            ),
            space,
            Column(
              children: [
                EditableText(
                  smartDashesType: SmartDashesType.enabled,
                  smartQuotesType: SmartQuotesType.enabled,
                  backgroundCursorColor: Theme.of(context).hoverColor,
                  controller: _controllerDesc,
                  cursorColor: Theme.of(context).hoverColor,
                  style: Theme.of(context).textTheme.bodyText1 ?? TextStyle(),
                  focusNode: _nodeDesc,
                  maxLines: 3,
                  minLines: 2,
                  forceLine: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget get space => SizedBox(
        height: ScreenUtil().setHeight(25),
      );

  _saveNote() async {
    DatabaseHelper _databaseHelper = DatabaseHelper();
    Note _note = Note(
        title: _controllerTitle.text,
        description: _controllerDesc.text,
        created: DateTime.now());

    if (widget.note != null) {
      _note.id = widget.note?.id;
      var result = await _databaseHelper.updateNode(_note);
      if (result != false) {
        Navigator.pop(context, _note);
      } else {}
    } else {
      var result = await _databaseHelper.saveNote(_note);
      if (result != false) {
        Navigator.pop(context);
      }
    }
  }
}
