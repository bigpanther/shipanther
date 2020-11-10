import 'package:flutter/material.dart';

class NotificationTestScreen extends StatelessWidget {
  final String task;
  NotificationTestScreen(this.task);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          task,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
