import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hudu_interview_application/models/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo_list.g.dart';

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  @override
  // TODO: Pull from local storage (Hive) or remote API
  // For now, we will generate a list of 10 todos for demonstration purposes.
  // List<Todo> build() => ref.read(getTodoItemsProvider).value.items;
  List<Todo> build() => state = List.generate(20, (index) {
    return Todo(
      id: const Uuid().v4(),
      title: 'Todo $index',
      description: 'Description for Todo $index',
      isCompleted: index % 2 == 0, // Just for example, some todos are completed
    );
  });

  void addTodo(String title, String description) {
    state = [
      ...state,
      Todo(id: const Uuid().v4(), title: title, description: description),
    ];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggleTodoCompleted(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.changeCompleted(todo);
      }
      return todo;
    }).toList();
  }

  //Change to state saves to Hive
}
