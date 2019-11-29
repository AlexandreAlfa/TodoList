import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
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

  @override
  int get schemaVersion => 1;
}
