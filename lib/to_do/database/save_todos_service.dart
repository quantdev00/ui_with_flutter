import 'dart:async';
import 'dart:developer';

import 'package:auth_phone/to_do/constant/constant.dart';
import 'package:auth_phone/to_do/database/database_todo.dart';
import 'package:auth_phone/to_do/database/exceptions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SaveTodosService {
  Database? _db;
  List<DatabaseTodo> _todos = [];

  var _todoStreamController = StreamController<List<DatabaseTodo>>.broadcast();

  Stream<List<DatabaseTodo>> get allTodos => _todoStreamController.stream;

  //*Making it singleton
  static final SaveTodosService _shared = SaveTodosService._sharedInstance();
  SaveTodosService._sharedInstance() {
    _todoStreamController =
        StreamController<List<DatabaseTodo>>.broadcast(onListen: () {
      _todoStreamController.sink.add(_todos);
    });
  }
  factory SaveTodosService() => _shared;

  Future<void> _cashedTodo() async {
    final allTodo = await getAllTodos();
    _todos = allTodo.toList();
    _todoStreamController.add(_todos);
  }

  //open the db
  Future<void> openDb() async {
    try {
      if (_db != null) {
        throw DbIsAlreadyOpenedException;
      }
    } on DbIsAlreadyOpenedException {
      await _db!.delete(todoTableName);
    }
    try {
      //connecting to our db
      final pathDocs = await getApplicationDocumentsDirectory();
      final dbPath = join(pathDocs.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      await db.execute(createDbQuery);
      await _cashedTodo();
      log('Db opened and created');
    } on MissingPlatformDirectoryException catch (e) {
      log('Error $e');
      throw CouldNotOpenTheDocumentDirectory;
    }
  }

  // Future<void> _ensureDbIsOpen() async {
  //   try {
  //     await openDb();
  //     log('Db opened');
  //   } on DbIsAlreadyOpenedException {
  //     log('Db already opened failed to open');
  //   }
  // }

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

  Future<DatabaseTodo> createTodo({
    required String todoText,
    required int isChecked,
  }) async {
    final db = _getOrThrowDb();
    final results = await db.query(
      todoTableName,
      limit: 1,
      where: 'todoText = ?',
      whereArgs: [todoText],
    );
    if (results.isNotEmpty) {
      DatabaseTodo? todo;
      await updateTodo(todo: todo!, text: todoText);
    }
    final todoId = await db.insert(todoTableName, {
      todoTextColumn: todoText,
      todoIsCheckedColumn: isChecked,
    });
    final todo = DatabaseTodo(
      todoId: todoId,
      todoText: todoText,
      isChecked: isChecked,
    );
    _todos.add(todo);
    _todoStreamController.add(_todos);
    return todo;
  }

  Future<DatabaseTodo> updateTodo({
    required DatabaseTodo todo,
    required String text,
  }) async {
    final db = _getOrThrowDb();
    await getTodos(todoText: todo.todoText);
    final updateCount = await db.update(todoTableName, {
      todoTextColumn: text,
    });
    if (updateCount == 0) {
      throw CouldNotUpdateTodo;
    } else {
      final updatedTodos = await getTodos(todoText: todo.todoText);
      _todos.removeWhere((todo) => todo.todoText == updatedTodos.todoText);
      _todoStreamController.add(_todos);
      return updatedTodos;
    }
  }

  Future<DatabaseTodo> updateIsChecked({
    required DatabaseTodo todo,
    required String text,
  }) async {
    final db = _getOrThrowDb();
    await getTodos(todoText: todo.todoText);
    final updateCount = await db.update(todoTableName, {
      todoIsCheckedColumn: 1,
    });
    if (updateCount == 0) {
      throw CouldNotUpdateIsCheckedTodo;
    } else {
      final updatedTodos = await getTodos(todoText: todo.todoText);
      _todos.removeWhere((todo) => todo.todoText == updatedTodos.todoText);
      _todoStreamController.add(_todos);
      return updatedTodos;
    }
  }

  Future<Iterable<DatabaseTodo>> getAllTodos() async {
    final db = _getOrThrowDb();
    final todos = await db.query(
      todoTableName,
    );
    final result = todos.map((todosRow) => DatabaseTodo.fromRow(todosRow));
    return result;
  }

  Future<DatabaseTodo> getTodos({required String todoText}) async {
    final db = _getOrThrowDb();
    final results = await db.query(
      todoTableName,
      limit: 1,
      where: 'todoText = ?',
      whereArgs: [todoText],
    );
    if (results.isEmpty) {
      throw CouldNotFindTodo();
    }
    final todo = DatabaseTodo.fromRow(results.first);
    _todos.removeWhere((todo) => todo.todoText == todoText);
    _todos.add(todo);
    _todoStreamController.add(_todos);
    return todo;
  }

  //Delete to do
  Future<void> deleteTodo({required String todoText}) async {
    final db = _getOrThrowDb();
    final results = await db.query(
      todoTableName,
      limit: 1,
      where: 'todoText = ?',
      whereArgs: [todoText],
    );

    if (results.isEmpty) {
      throw CouldNotFindTodo;
    } else {
      final deleteTodo = await db
          .delete(todoTableName, where: 'todoText = ?', whereArgs: [todoText]);
      if (deleteTodo != 1) {
        throw CouldNotDeleteTodo;
      }
      _todos.removeWhere((todo) => todo.todoText == todoText);
      _todoStreamController.add(_todos);
    }
  }

  int getId(DatabaseTodo todoId) {
    return todoId.todoId;
  }

  Future<int> deleteAllTodos() async {
    final db = _getOrThrowDb();
    var allTodosNumberOfDeletion = await db.delete(todoTableName);
    _todos = [];
    _todoStreamController.add(_todos);
    return allTodosNumberOfDeletion;
  }
}
