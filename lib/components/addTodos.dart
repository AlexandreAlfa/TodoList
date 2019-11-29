import 'package:flutter/material.dart';
import 'package:todolist/db/database.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController reader = TextEditingController();
  DataBase base = DataBase.database;
  @override
  void dispose() {
    reader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Todo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: reader,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            RaisedButton(
              child: Text('Adicionar'),
              onPressed: () {
                if (reader.text.isNotEmpty) {
                  base.addTodo(
                      Todo(description: reader.text, completed: false));
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
