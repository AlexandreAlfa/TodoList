import 'package:flutter/material.dart';
import 'package:todolist/components/addTodos.dart';
import 'package:todolist/db/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //final bloc = BlocProvider.getBloc<DataBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lista de Tarefas'),
      ),
      body: StreamBuilder<List<Todo>>(
        stream: DataBase.database.getAll(),
        initialData: [],
        builder: (context, snapshot) {
          List<Todo> todos = snapshot.data;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                child: ListTile(
                  title: Text(todos[index].description),
                  trailing: IconButton(
                    icon: todos[index].completed
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.greenAccent,
                          )
                        : Icon(Icons.check_circle_outline),
                    onPressed: () {
                      DataBase.database
                          .completed(todos[index].id, !todos[index].completed);
                    },
                  ),
                ),
                onDismissed: (direction) {
                  DataBase.database.deleteTodo(todos[index].id);
                  Scaffold.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("${todos[index].description} excluido")));
                  Scaffold.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 1),
                      content:
                          Text("Não possivel excluir tarefa não concluida.")));
                },
                background: Container(
                  color: Colors.red,
                  child: Icon(Icons.delete),
                ),
                key: Key(todos[index].id.toString()),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddTodo()));
        },
      ),
    );
  }
}
