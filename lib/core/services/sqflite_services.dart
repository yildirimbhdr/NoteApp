import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:notes_app/core/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper!;
    } else {
      return _databaseHelper!;
    }
  }
  DatabaseHelper._internal();

  Future<Database?> _getDatabase() async {
    if (_database == null) {
      _database = await initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "notes.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("asset", "notes.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {}
    var db = await openDatabase(path, readOnly: false);
    return db;
  }

  getNotes() async {
    var db = await _getDatabase();
    List<Map<String, dynamic>>? a = await db?.rawQuery("SELECT *FROM notes");
    return a?.map((e) => Note.fromJson(e)).toList();
  }

  saveNote(Note note) async {
    var db = await _getDatabase();
    var result = await db?.insert("notes", note.toJson());
    return result;
  }

  getNotesWithKey(String key) async {
    var db = await _getDatabase();
    List<Map<String, dynamic>>? a =
        await db?.rawQuery("SELECT *FROM notes WHERE title LIKE '%$key%'");
    return a?.map((e) => Note.fromJson(e)).toList();
  }

  updateNode(Note? note) async {
    var db = await _getDatabase();
    var result = await db?.rawUpdate(
        "UPDATE notes SET title='${note?.title ?? ""}' , description='${note?.description ?? ""}' WHERE id=${note?.id ?? 0}");
    print(result);
    return result;
  }
}
