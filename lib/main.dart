import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo List',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white, foregroundColor: Colors.orange)),
        home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                'Mark "${_todoItems[index]}" as done?',
                style: TextStyle(color: Colors.orange),
              ),
              actions: <Widget>[
                FlatButton(
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.orange),
                    ),
                    onPressed: () => Navigator.of(context).pop()),
                FlatButton(
                    child: Text(
                      'I FINISHED THAT!!',
                      style: TextStyle(color: Colors.orange),
                    ),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return ListTile(
        title: Text(todoText), onTap: () => _promptRemoveTodoItem(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ToDo List')),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: Icon(Icons.add)),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(title: Text('Add a new task')),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: InputDecoration(
                hintText: 'Enter new task',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }
}
