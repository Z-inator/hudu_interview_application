import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hudu_interview_application/models/todo.dart';
import 'package:hudu_interview_application/notifiers/todo_list.dart';

Widget todoItem({required Todo todo}) {
  return Consumer(
    builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (value) {
            ref
                .read(todoListNotifierProvider.notifier)
                .toggleTodoCompleted(todo.id);
          },
        ),
        title: Text(todo.title),
        subtitle: Text(todo.description),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            ref.read(todoListNotifierProvider.notifier).removeTodo(todo.id);
          },
        ),
      );
    },
  );
}
