import 'package:hive_ce/hive.dart';

class Todo extends HiveObject{
  Todo(
    {required this.id, 
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  Todo changeCompleted(Todo todo) {
    return Todo(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isCompleted: !todo.isCompleted,
    );
  }
}
