import 'package:notes_app/core/init/extension/date_time_extension.dart';
import 'package:notes_app/core/init/extension/string_extension.dart';

class Note {
  int? id;
  String? title;
  String? description;
  DateTime? created;

  Note({this.id, this.title, this.description, this.created});

  Note.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    title = json['title'];
    description = json['description'];
    created = json['created'].toString().convertDateTime();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data["created"] = this.created?.toBackEnd();
    //data['created'] = this.created;
    return data;
  }
}
