import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utils/hive_helper.dart';

final todoListProvider = StateNotifierProvider<TodosList, List<Todo>>(
  (ref) => TodosList(),
);

class TodosList extends StateNotifier<List<Todo>> {
  TodosList([List<Todo>? initialTodos]) : super(initialTodos ?? []) {
    String? savedTodos = HiveHelper.todosBox.get('todos');
    List todoJson = jsonDecode(savedTodos ?? '[]');
    state = todoJson.map((e) => Todo.fromMap(e)).toList();
  }

  Future<bool> addTodo(Todo todo) async {
    try {
      state = [...state, todo];
      _saveToLocalDB();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> toggleTodo(String id, bool isCompleted) async {
    try {
      state = [
        for (final todo in state)
          if (todo.id == id) todo.copyWith(isCompleted: isCompleted) else todo
      ];
      _saveToLocalDB();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTodo(String id) async {
    try {
      final oldState = state;
      oldState.removeWhere((element) => element.id == id);
      state = [...oldState];
      _saveToLocalDB();
      return true;
    } catch (e) {
      return false;
    }
  }

  void _saveToLocalDB() {
    List todosMap = state.map((e) => e.toMap()).toList();
    HiveHelper.todosBox.put('todos', jsonEncode(todosMap));
  }
}
