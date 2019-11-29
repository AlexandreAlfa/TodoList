import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();
  TextColumn get description => text()();
  BoolColumn get completed => boolean()();
}

class Favorites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idTodo => integer().nullable()();
}

@UseMoor(tables: [Todos])
class DataBase extends _$DataBase {
  static final DataBase database = DataBase._internal();
  DataBase._internal()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  Stream getAll() {
    return select(todos).watch();
  }

  addTodo(Todo todo) {
    return into(todos).insert(todo);
  }

  deleteTodo(int id) {
    return (delete(todos)..where((todo) => todo.id.equals(id))).go();
  }

  completed(int id, bool completed) {
    return (update(todos)..where((filter) => filter.id.equals(id)))
        .write(TodosCompanion(completed: Value(completed)));
  }

  @override
  int get schemaVersion => 1;
}
