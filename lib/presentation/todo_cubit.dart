import 'package:bloc/bloc.dart';
import 'package:todoapp_v2/domain/models/todo.dart';

import '../domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }
  // load
  Future<void> loadTodos() async {
    final todolist = await todoRepo.getTodos();

    emit(todolist);
  }

  // add
  Future<void> addTodo(String text) async {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );

    await todoRepo.addTodo(newTodo);

    loadTodos();
  }

  // delete
  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    loadTodos();
  }

  // toggle
  Future<void> toggleCompletion(Todo todo) async {
    final updatedTodo = todo.toggleComplete();
    await todoRepo.updateTodo(updatedTodo);
    loadTodos();
  }
}
