import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp_v2/presentation/todo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoTile extends StatelessWidget {
  final todo;
  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return Dismissible(
      onDismissed: (direction) => todoCubit.deleteTodo(todo),
      key: ValueKey(todo.id),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow[300],
            borderRadius: BorderRadiusDirectional.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.yellow,
                checkColor: Colors.black,
                value: todo.isCompleted,
                onChanged: (value) => todoCubit.toggleCompletion(todo),
              ),
              Expanded(
                  child: Text(
                todo.text,
                style: GoogleFonts.gloriaHallelujah(
                    fontSize: 26,
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

/*
Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadiusDirectional.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskComplete,
                onChanged: onChanged,
                activeColor: Colors.yellow,
                checkColor: Colors.black,
              ),
              Text(
                taskName,
                
              ),
            ],
          ),
        ),
      )
*/