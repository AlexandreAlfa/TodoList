import 'package:flutter/material.dart';
import 'package:todolist/pages/home.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [],
      dependencies: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista de Tarefas',
        home: Home(),
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
      ),
    );
  }
}
