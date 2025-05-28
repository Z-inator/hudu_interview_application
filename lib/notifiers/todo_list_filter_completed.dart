import 'package:hudu_interview_application/models/todo_model.dart';
import 'package:hudu_interview_application/notifiers/todo_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_list_filter_completed.g.dart';

@riverpod
class ToDoListFilterCompleted extends _$ToDoListFilterCompleted {

  @override
  List<Todo> build() {
    return ref.watch(todoListNotifierProvider)
      .where((todo) => todo.isCompleted == true)
      .toList();
  }
}
