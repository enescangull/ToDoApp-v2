import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_v2/presentation/todo_cubit.dart';
import 'package:todoapp_v2/presentation/todo_screen.dart';

import '../domain/repository/todo_repo.dart';

class TodoPage extends StatelessWidget {
  final TodoRepo todoRepo;

  const TodoPage({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todoRepo),
      child: const TodoScreen(),
    );
  }
}
