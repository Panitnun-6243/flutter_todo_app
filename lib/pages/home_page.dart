import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceWidth, _deviceHeight;
  String? _newTaskContent;

  _HomePageState();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    print("Input Value: $_newTaskContent");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Todo List!",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        toolbarHeight: _deviceHeight * 0.1,
      ),
      body: _tasksView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _tasksView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.connectionState == ConnectionState.done) {
          return _tasksList();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _tasksList() {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            'Learn Flutter',
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          subtitle: Text(
            DateTime.now().toString(),
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.check_box_outlined),
            onPressed: () {},
            color: Colors.lightGreen,
          ),
        ),
      ],
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void _displayTaskPopup() {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text("Add new task"),
          content: TextField(
            onSubmitted: (_value) {},
            onChanged: (_value) {
              setState(() {
                _newTaskContent = _value;
              });
            },
          ),
        );
      },
    );
  }
}
