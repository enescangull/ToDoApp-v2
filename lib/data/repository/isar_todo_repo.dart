import 'package:isar/isar.dart';
import 'package:todoapp_v2/data/models/isar_todo.dart';
import 'package:todoapp_v2/domain/models/todo.dart';
import 'package:todoapp_v2/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar db;

  IsarTodoRepo(this.db);

  @override
  Future<List<Todo>> getTodos() async {
    //fetch from db
    final todos = await db.todoIsars.where().findAll();
    //return as a list of todos and give domain layer
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  @override
  Future<void> addTodo(Todo newTodo) async {
    // convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(newTodo);
    //store in db
    return db.writeTxn(
      () => db.todoIsars.put(todoIsar),
    );
  }

  @override
  Future<void> updateTodo(Todo todo) {
    // convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(todo);
    //store in db
    return db.writeTxn(
      () => db.todoIsars.put(todoIsar),
    );
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(
      () => db.todoIsars.delete(todo.id),
    );
  }
}
