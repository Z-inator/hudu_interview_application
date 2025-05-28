
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hudu_interview_application/database/hive_registrar.g.dart';
import 'package:hudu_interview_application/models/todo_model.dart';
import 'package:hudu_interview_application/ui_elements/add_todo_button.dart';
import 'package:hudu_interview_application/ui_elements/todo_list_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox<Todo>('todosBox');
  Hive.box<Todo>('todosBox').listenable();
  
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hudu Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("To Do App"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Not Completed'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: TodoListTabs(key: const Key('todo_lists'))),
          ],
        ),
        floatingActionButton: AddTaskButton(),
      ),
    );
  }
}
