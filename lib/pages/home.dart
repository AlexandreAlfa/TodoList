import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:todolist/db/data_bloc.dart';
import 'package:todolist/db/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bloc = BlocProvider.getBloc<DataBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lista de Tarefas'),
      ),
      body: StreamBuilder<List<Todo>>(
        stream: bloc.output,
        initialData: [],
        builder: (context, snapshot) {
          List<Todo> todos = snapshot.data;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(todos[index].description),
                trailing: todos[index].completed
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.greenAccent,
                      )
                    : Icon(Icons.check_circle_outline),
              );
            },
          );
        },
      ),
    );
  }
}
