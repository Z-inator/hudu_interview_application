import 'package:hive_ce/hive.dart';
import 'package:hudu_interview_application/models/todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_list.g.dart';

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  @override
  List<Todo> build() => state = Hive.box<Todo>('todosBox').values.toList();
  // List<Todo> build() => state = List.generate(20, (index) {
  //   return Todo(
  //     id: const Uuid().v4(),
  //     title: 'Todo $index',
  //     description: 'Description for Todo $index',
  //     isCompleted: index % 2 == 0, // Just for example, some todos are completed
  //   );
  // });

  void addTodo(Todo todo) {
    state = [
      ...state,
      todo,
    ];
    Hive.box<Todo>('todosBox').add(todo);
  }

  void removeTodo(Todo todo) {
    state.removeWhere((todoItem) => todoItem.id == todo.id);
    Hive.box<Todo>('todosBox').delete(todo);
  }

  void toggleTodoCompleted(Todo todo) {
    state = state.map((todoItem) {
      if (todoItem.id == todo.id) {
        return todoItem.changeCompleted(todoItem);
      }
      return todoItem;
    }).toList();
    todo.changeCompleted(todo).save();
  }
}
