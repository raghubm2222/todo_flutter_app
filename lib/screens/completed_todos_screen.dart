import 'package:flutter/material.dart';
import 'package:todo_app/widgets/todos_list_view.dart';

class CompletedTodosScreen extends StatelessWidget {
  const CompletedTodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Completed Todos')),
      body: const TodosListView(showCompleted: true),
    );
  }
}
