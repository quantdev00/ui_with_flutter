import 'package:auth_phone/to_do/constant/constant.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

@immutable
class DatabaseTodo {
  final int todoId;
  final String todoText;
  final bool isChecked;

  const DatabaseTodo({
    required this.todoId,
    required this.todoText,
    required this.isChecked,
  });
  DatabaseTodo.fromRow(Map<String, Object> map)
      : todoId = map[todoIdColumn] as int,
        todoText = map[todoTextColumn] as String,
        isChecked = (map[todoIsCheckedColumn] as bool);

  @override
  String toString() =>
      'To do Id : $todoId, todoText : $todoText, Is Checked : $isChecked';

  //making sure that the id is the same
  @override
  operator ==(covariant DatabaseTodo other) => todoId == other.todoId;

  @override
  int get hashcode => todoId.hashCode;
}
