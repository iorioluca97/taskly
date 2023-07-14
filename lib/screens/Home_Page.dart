import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceWidth, _deviceHeigth;

  String? _newTaskContent;
  Box? _box;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeigth = MediaQuery.of(context).size.height;
    print("Input value: $_newTaskContent");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Taskly!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        toolbarHeight: _deviceHeigth * 0.15,
      ),
      body: _taskView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _tasksList() {
    //  Task _newTask = Task(
    //    content: 'Go to gym',
    //    timestamp: DateTime.now(),
    //    isDone: false,
    //  );
    //  _box?.add(_newTask.toMap());

    List tasks = _box!.values.toList();
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          var task = Task.fromMap(tasks[index]);
          return ListTile(
            subtitle: Text(task.timestamp.toString().split('.')[0]),
            title: Text(
              task.content,
              style: TextStyle(
                decoration: task.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: Icon(
              task.isDone
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              color: task.isDone ? Colors.green : Colors.red,
            ),
            onTap: () {
              task.isDone = !task.isDone;
              _box!.putAt(index, task.toMap());
              setState(() {});
            },
            onLongPress: () {
              _box!.deleteAt(index);
              setState(() {});
            },
          );
        });
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        dispalyTaskPopUp();
      },
      child: const Icon(Icons.add),
    );
  }

  void dispalyTaskPopUp() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add new task"),
            content: TextField(
              onSubmitted: (_) {
                if (_newTaskContent != null) {
                  Task newTask = Task(
                    content: _newTaskContent!,
                    timestamp: DateTime.now(),
                    isDone: false,
                  );
                  _box!.add(newTask.toMap());
                  setState(() {
                    _newTaskContent = null;
                    Navigator.pop(context);
                  });
                }
              },
              onChanged: (value) {
                setState(() {
                  _newTaskContent = value;
                });
              },
            ),
          );
        });
  }

  Widget _taskView() {
    return FutureBuilder(
      future: Hive.openBox('task'),
      //Future.delayed(Duration(seconds: 2)),
      builder: (
        BuildContext _context,
        AsyncSnapshot _snapshot,
      ) {
        if (_snapshot.hasData) {
          _box = _snapshot.data;
          return _tasksList();
        } else {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 8,
            ),
          );
        }
      },
    );
  }
}
