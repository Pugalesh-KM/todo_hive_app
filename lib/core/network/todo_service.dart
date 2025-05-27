import 'package:hive/hive.dart';
import 'package:todo_hive_app/features/home/data/models/todo.dart';


class TodoService {
  static final TodoService _instance = TodoService._internal();
  factory TodoService() => _instance;
  TodoService._internal();

  final Box<Todo> _todoBox = Hive.box<Todo>('todos');

  /// Create
  Future<void> addTodo({ required String title,  required String subtitle}) async {
    final newTodo = Todo(title: title, subtitle: subtitle, isDone: false);
    await _todoBox.add(newTodo);
  }

  /// Read
  List<Todo> getTodos() {
    return _todoBox.values.toList();
  }

  /// Update
  Future<void> updateTodo({required int index,
    required String newTitle,
    required String newSubtitle,
    required bool isDone,
  }) async {
    final todo = _todoBox.get(index);
    if (todo != null) {
      todo.title = newTitle;
      todo.subtitle = newSubtitle;
      todo.isDone = isDone;
      await todo.save();
    }
  }

  /// Change
  Future<void> toggleDone(int index) async {
    final todo = _todoBox.get(index);
    if (todo != null) {
      todo.isDone = !todo.isDone;
      await todo.save();
    }
  }

  /// Delete
  Future<void> deleteTodo(int index) async {
    await _todoBox.delete(index);
  }

  /// Delete undo
  Future<void> undoTodo(Todo todo) async {
    await _todoBox.add(todo);
  }

  /// all delete
  Future<List<Todo>> deleteCompletedTodos() async {
    final completedTodos = _todoBox.values
        .where((todo) => todo.isDone)
        .toList();

    final completedKeys = _todoBox.keys
        .where((key) => _todoBox.get(key)?.isDone == true)
        .toList();

    await _todoBox.deleteAll(completedKeys);

    return completedTodos;
  }

  /// all delete -- undo
  Future<void> restoreTodos(List<Todo> todos) async {
    for (final todo in todos) {
      await _todoBox.add(todo);
    }
  }
}
