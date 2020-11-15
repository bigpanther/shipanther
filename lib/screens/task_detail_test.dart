import 'package:flutter/material.dart';

class TaskDetailTest extends StatelessWidget {
  String id;
  String from;
  String to;
  DateTime pickupTime;
  String containerName;
  TaskDetailTest(
      this.id, this.from, this.to, this.pickupTime, this.containerName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(id),
            Text('$from To $to At $pickupTime'),
            Text(containerName),
          ],
        ),
      ),
    );
  }
}
