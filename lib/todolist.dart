import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _Task {
  _Task(this.title);

  final String title;
  bool isDone = false;
}

class _TodoListState extends State<TodoList> {
  final List<_Task> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addNewTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add(_Task(_controller.text));
        _controller.clear();
      });
    }
  }
  void _showdialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'), titleTextStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Color.fromRGBO(0, 0, 0, 1)),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter task title'), 
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'), style: TextButton.styleFrom(backgroundColor: const Color.fromARGB(255, 250, 150, 143)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'), style: TextButton.styleFrom(backgroundColor: const Color.fromARGB(255, 156, 247, 159)),
              onPressed: () {
                _addNewTask();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Morning Rei, What are you going to do today?',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body:ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card( color: const Color.fromARGB(255, 188, 219, 233), 
            child: CheckboxListTile(
              value: task.isDone, checkColor: const Color.fromARGB(255, 8, 187, 32),
              title: Text(task.title),
              onChanged: (isDone) {
                setState(() {
                  task.isDone = isDone ?? false;
                });
              },
            ),
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showdialog();
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}