import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todolist/db/database.dart';

class DataBloc extends BlocBase {
  DataBase base = DataBase.database;
  BehaviorSubject<List<Todo>> controller = BehaviorSubject<List<Todo>>();
  Sink get input => controller.sink;
  Stream<List<Todo>> get output => controller.stream;

  getAll() => input.add(base.getAll());

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
