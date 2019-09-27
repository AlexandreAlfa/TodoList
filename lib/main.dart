import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/item.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de tarefas',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  var items = List<Item>();

  Home() {
    items = [];
  }
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller = TextEditingController();

  add() {
    setState(() {
      widget.items.add(
          Item(title: _controller.text, done: false, date: DateTime.now()));
      save();
    });
  }

  remove(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  Future<void> load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);

      List<Item> result = decoded.map((f) => Item.fromJson(f)).toList();

      setState(() {
        widget.items = result;
      });
    }
  }

  Future<void> save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

  _HomeState() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          keyboardType: TextInputType.text,
          controller: _controller,
          style: TextStyle(color: Colors.white, fontSize: 25),
          decoration: InputDecoration(
              labelText: 'Nova tarefa',
              labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
      body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return Dismissible(
              child: CheckboxListTile(
                value: item.done,
                activeColor: Colors.redAccent,
                title: Text(item.title),
                subtitle: Text(item.date.toString()),
                onChanged: (value) {
                  setState(() {
                    item.done = value;
                    item.date = DateTime.now().toLocal();
                    save();
                  });
                },
              ),
              key: Key(item.title),
              background: Container(
                color: Colors.deepPurpleAccent.withOpacity(.8),
                child: Text(
                  'Excluir',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              onDismissed: (direction) {
                remove(index);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            add();
            save();
          }
        },
      ),
    );
  }
}
