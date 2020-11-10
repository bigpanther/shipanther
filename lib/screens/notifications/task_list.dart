import 'package:flutter/material.dart';

import 'notification_test.dart';

class Task {
  List<String> sample = ['Task 1', 'Task 2', 'Task 3'];
  List<String> showTask() {
    return sample;
  }

  void addTask(String newTask) {
    sample.add(newTask);
  }

  int taskCount() {
    return sample.length;
  }
}

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  Widget tile(String task) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _pushPage(context, NotificationTestScreen(task));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              task,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shipanther"),
        ),
        body: ListView.builder(
          itemCount: Task().taskCount(),
          itemBuilder: (context, index) {
            return tile(Task().showTask()[index]);
          },
        ));
  }
}
