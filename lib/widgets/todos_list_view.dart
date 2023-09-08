import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todos_provider.dart';
import 'package:todo_app/utils/utils.dart';

class TodosListView extends ConsumerWidget {
  const TodosListView({super.key, this.showCompleted = false});

  final bool showCompleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoListProvider);
    if (showCompleted) {
      todos = todos.where((element) => element.isCompleted).toList();
    } else {
      todos = todos.where((element) => !element.isCompleted).toList();
    }
    if (todos.isEmpty) {
      return  Center(
        child: Text(
          '${showCompleted?'Completed':''} Todos not found',
          style: const TextStyle(fontSize: 18),
        ),
      );
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (value) => {
              ref.read(todoListProvider.notifier).toggleTodo(
                    todo.id,
                    value!,
                  ),
            },
          ),
          title: Text(
            todo.title,
          ),
          subtitle: Text(
            todo.description,
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: const Text('Delete Todo?'),
                  content: Text(
                    'Do you want to delete ${todo.title} todo. Are you sure?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(todoListProvider.notifier).deleteTodo(todo.id);
                        Navigator.pop(context);
                        Utils.showMessage(context, 'Todo deleted succesfully');
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.delete_outline_outlined,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
