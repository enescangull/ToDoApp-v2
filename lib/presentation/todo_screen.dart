import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_v2/domain/models/todo.dart';
import 'package:todoapp_v2/presentation/components/todo_tile.dart';
import 'package:todoapp_v2/presentation/todo_cubit.dart';
import 'package:todoapp_v2/presentation/todo_page.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: controller,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                todoCubit.addTodo(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text("Save")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text(
          "To Do List",
          style: GoogleFonts.permanentMarker(fontSize: 32),
        ),
      ),
      backgroundColor: Colors.yellow[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () => _showAddTodoBox(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoTile(todo: todo);
            },
          );
        },
      ),
    );
  }
}
