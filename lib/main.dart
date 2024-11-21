import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:todoapp_v2/data/models/isar_todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp_v2/data/repository/isar_todo_repo.dart';
import 'package:todoapp_v2/domain/repository/todo_repo.dart';
import 'package:todoapp_v2/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //get directory path for storing data
  final dir = await getApplicationDocumentsDirectory();

  //open isar db
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

  //initialize the repo iwt isar db
  final isarTodoRepo = IsarTodoRepo(isar);
  runApp(MyApp(
    todoRepo: isarTodoRepo,
  ));
}

class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;
  const MyApp({super.key, required this.todoRepo});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        useMaterial3: true,
      ),
      home: TodoPage(
        todoRepo: todoRepo,
      ),
    );
  }
}
