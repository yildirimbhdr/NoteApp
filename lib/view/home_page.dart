import 'package:flutter/material.dart';
import 'package:notes_app/core/constant/size_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/core/models/note.dart';
import 'package:notes_app/core/services/sqflite_services.dart';
import 'package:notes_app/view/note_add_page.dart';
import 'package:notes_app/view/note_detail_page.dart';
import 'package:notes_app/view/shared/buttons/container_button.dart';
import 'package:notes_app/view/shared/container/note_container.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> _notes = [];
  TextEditingController _controllerSearch =
      TextEditingController(text: "Notes");
  FocusNode _node = FocusNode();
  @override
  void initState() {
    super.initState();
    getNotes();
    _controllerSearch.addListener(() {
      if (_controllerSearch.text != "Notes") {
        getNotesWithKey(_controllerSearch.text);
      } else {
        getNotes();
      }
    });
  }

  getNotes() async {
    DatabaseHelper _databaseHelper = DatabaseHelper();
    _notes = await _databaseHelper.getNotes();
    setState(() {});
  }

  getNotesWithKey(String key) async {
    DatabaseHelper _databaseHelper = DatabaseHelper();
    _notes = await _databaseHelper.getNotesWithKey(key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          shrinkWrap: true,
          padding: SizeConstant.instance.pagePadding,
          children: [title, space, notes],
        ),
        floatingActionButton: floatingActionButton);
  }

  Widget get space => SizedBox(
        height: ScreenUtil().setHeight(25),
      );
  Widget get title => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 200,
            child: AbsorbPointer(
              child: EditableText(
                  onSelectionHandleTapped: () {},
                  controller: _controllerSearch,
                  focusNode: _node,
                  style: Theme.of(context).textTheme.headline2 ?? TextStyle(),
                  cursorColor: Theme.of(context).hoverColor,
                  backgroundCursorColor: Theme.of(context).hoverColor),
            ),
          ),
          ContainerButton(
            icon: Icons.search,
            onTap: () {
              if (_controllerSearch.text == "Notes") {
                if (_node.hasFocus) {
                  _node.unfocus();
                } else {
                  _node.requestFocus();
                  _controllerSearch.text = "";
                }
              } else {
                if (_node.hasFocus) {
                  _node.unfocus();
                } else {
                  _node.requestFocus();
                }
              }
              if (_controllerSearch.text.isEmpty) {
                _controllerSearch.text = "Notes";
              }
            },
          )
        ],
      );
  FloatingActionButton get floatingActionButton => FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteAddPage(),
            ),
          );
          getNotes();
        },
        child: Icon(Icons.add),
      );
  Widget get notes => Container(
        constraints: BoxConstraints(
          minHeight: ScreenUtil().setHeight(500),
        ),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: ScreenUtil().setHeight(25),
          crossAxisSpacing: ScreenUtil().setWidth(25),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            Note _note = _notes[index];
            return InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailPage(
                      note: _note,
                    ),
                  ),
                );
                getNotes();
              },
              child: Column(
                children: [
                  NoteContainer(
                    note: _note,
                  ),
                ],
              ),
            );
          },
        ),
      );
}
