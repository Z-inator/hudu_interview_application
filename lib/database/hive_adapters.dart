import 'package:hive_ce/hive.dart';
import 'package:hudu_interview_application/models/todo_model.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<Todo>()
])

class HiveAdapters {
  
}