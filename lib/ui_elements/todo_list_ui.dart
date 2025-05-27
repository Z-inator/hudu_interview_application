import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hudu_interview_application/models/todo.dart';
import 'package:hudu_interview_application/notifiers/todo_list.dart';
import 'package:hudu_interview_application/notifiers/todo_list_filter_completed.dart';
import 'package:hudu_interview_application/notifiers/todo_list_filter_not_completed.dart';
import 'package:hudu_interview_application/ui_elements/todo_item.dart';

class TodoListTabs extends StatelessWidget {
  const TodoListTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        List<Todo> todos = ref.watch(todoListNotifierProvider);
        List<Todo> notCompletedTodos = ref.watch(
          toDoListFilterNotCompletedProvider,
        );
        List<Todo> completedTodos = ref.watch(toDoListFilterCompletedProvider);
        return TabBarView(
          children: [
            todos.isEmpty
                ? const Center(child: Text("No Todos"))
                : TodoList(todos: todos),
            notCompletedTodos.isEmpty
                ? const Center(child: Text("No Not Completed Todos"))
                : TodoList(todos: notCompletedTodos),
            completedTodos.isEmpty
                ? const Center(child: Text("No Completed Todos"))
                : TodoList(todos: completedTodos),
          ],
        );
      },
    );
  }
}

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  const TodoList({required this.todos, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return todoItem(todo: todo);
          },
        );
      },
    );
  }
}
