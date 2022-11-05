import 'dart:developer';

import 'package:auth_phone/to_do/database/database_todo.dart';
import 'package:auth_phone/to_do/database/save_todos_service.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final TextEditingController _textController;
  late final SaveTodosService _todoService;
  DatabaseTodo? _todo;

  Future<DatabaseTodo?> createNewTodo() async {
    final existingTodo = _todo;
    if (_todo != null) {
      return existingTodo;
    }

    return await _todoService.createTodo(
      todoText: _textController.text,
      isChecked: 0,
    );
  }

  void _deleteIfTextIsEmpty() async {
    final todo = _todo;
    if (_textController.text.isEmpty && _todo != null) {
      await _todoService.deleteTodo(todoText: todo!.todoText);
    }
  }

  void _saveTodoIfTextIsNotEmpty() async {
    final todo = _todo;
    final text = _textController.text;
    if (todo == null && text.isNotEmpty) {
      _todoService.createTodo(
        todoText: text,
        isChecked: 0,
      );
    }
  }

  void _textControllerListener() async {
    final todo = _todo;
    if (todo == null) {
      return;
    }
    final text = _textController.text;
    await _todoService.updateTodo(
      todo: todo,
      text: text,
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  @override
  void initState() {
    _todoService = SaveTodosService();
    _textController = TextEditingController();

    _todoService.openDb();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo',
        ),
      ),
      body: Column(children: [
        FutureBuilder(
            future: createNewTodo(),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  _todo = snapshot.data as DatabaseTodo;
                  _setupTextControllerListener();
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.all(20),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _textController,
                      keyboardAppearance: Brightness.dark,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add todo',
                      ),
                    ),
                  );
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            })),
        Container(
          height: 50,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextButton(
            child: const Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              _deleteIfTextIsEmpty();
              _saveTodoIfTextIsNotEmpty();
              _textController.dispose();
            },
          ),
        ),
        const SizedBox(height: 15),
        Container(
          child: StreamBuilder(
            stream: _todoService.allTodos,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final allTodos = snapshot.data as List<DatabaseTodo>;
                    log(allTodos.toString());
                    return const Text('Hello todos');
                  } else {
                    return const CircularProgressIndicator();
                  }
                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        )
      ]),
    );
  }
}
