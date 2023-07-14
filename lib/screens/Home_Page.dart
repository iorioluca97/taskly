import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceWidth;
  late double _deviceHeigth;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeigth = MediaQuery.of(context).size.height;
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
      body: _tasksList(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _tasksList() {
    return ListView(
      children: <Widget>[
        ListTile(
          subtitle: Text(DateTime.now().toString().split('.')[0]),
          title: Text(
            'Do laundry',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
            ),
          ),
          trailing: Icon(Icons.check_box_outlined, color: Colors.red),
        ),
        ListTile(
          subtitle: Text(DateTime.now().toString().split('.')[0]),
          title: Text(
            'Do laundry',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
            ),
          ),
          trailing: Icon(Icons.check_box_outlined, color: Colors.red),
        ),
      ],
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        print('Pressed _addTaskButton');
      },
      child: const Icon(Icons.add),
    );
  }
}
