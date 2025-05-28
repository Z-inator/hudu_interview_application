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
    state = state.where((testTodo) => testTodo.id != todo.id).toList();
    todo.delete();
  }

  void toggleTodoCompleted(Todo todo) {
    state = state.map((todoItem) {
      if (todoItem.id == todo.id) {
        // I would like to implement a cleaner approach but am having trouble with Hive claiming the todo isn't in the box
        Todo updatedTodo = todo.changeCompleted(todo);
        todo.delete();
        Hive.box<Todo>('todosBox').add(updatedTodo);
        return updatedTodo;
      }
      return todoItem;
    }).toList();
  }

}
