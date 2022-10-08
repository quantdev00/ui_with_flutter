import 'dart:developer';

import 'package:auth_phone/to_do/constant/constant.dart';
import 'package:auth_phone/to_do/database/database_todo.dart';
import 'package:auth_phone/to_do/database/exceptions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SaveTodosService {
  Database? _db;

  //open the db
  Future<void> openDb() async {
    if (_db != null) {
      throw DbIsAlreadyOpenedException;
    }
    try {
      //connecting to our db
      final pathDocs = await getApplicationDocumentsDirectory();
      final dbPath = join(pathDocs.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      await db.execute(createDbQuery);
    } on MissingPlatformDirectoryException catch (e) {
      log('Error $e');
      throw CouldNotOpenTheDocumentDirectory;
    }
  }

  Future<void> _ensureDbIsOpen() async {
    try {
      await openDb();
      log('Db opened');
    } on DbIsAlreadyOpenedException {
      log('Db failed to open');
    }
  }

  Future<void> closeDb() async {
    if (_db != null) {
      _db?.close();
      log('Db closed');
    } else {
      throw DbisNotOpenedException;
    }
  }

  Database _getOrThrowDb() {
    final db = _db;
    if (db == null) {
      throw DbisNotOpenedException();
    } else {
      return db;
    }
  }

  Future<DatabaseTodo> createTodo({required todoText}) async {
    await _ensureDbIsOpen();
    final db = _getOrThrowDb();

    var toCheck = false;
    final todoId = await db.insert(todoTableName, {
      todoIdColumn: todoText,
      todoIsCheckedColumn: toCheck,
    });
    return DatabaseTodo(
      todoId: todoId,
      todoText: todoText,
      isChecked: toCheck,
    );
  }

  //Delete to do
  Future<void> deleteTodo({required String todoText}) async {
    await _ensureDbIsOpen();
    final db = _db;
    final results = db?.query(todoTableName,
        limit: 1, where: 'todoText = ?', whereArgs: [todoText]);

    if (results == null) {
      throw CouldNotFindTodo;
    } else {
      final deleteTodo = await db
          ?.delete(todoTableName, where: 'todoText = ?', whereArgs: [todoText]);
      if (deleteTodo != 1) {
        throw CouldNotDeleteTodo;
      }
    }
  }

  Future<void> deleteAllTodos() async {
    await _ensureDbIsOpen();
    final db = _getOrThrowDb();
    var allNoteRows = await db.delete(todoTableName);
  }
}
