// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shipanther/blocs/models/task.dart';
import 'package:shipanther/blocs/task_bloc.dart';
import 'package:shipanther/screens/add_edit_screen.dart';
import 'package:shipanther/screens/task_detail_test.dart';
import 'package:shipanther/tasks_app_core/keys.dart';
import 'package:shipanther/tasks_app_core/localization.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String taskId;
  final TaskBloc Function() initBloc;

  DetailScreen({
    @required this.taskId,
    @required this.initBloc,
  }) : super(key: ArchSampleKeys.taskDetailsScreen);

  @override
  DetailScreenState createState() {
    return DetailScreenState();
  }
}

class DetailScreenState extends State<DetailScreen> {
  TaskBloc taskBloc;

  @override
  void initState() {
    super.initState();
    taskBloc = widget.initBloc();

    taskList = List<TaskSample>();
    _getToken();
    _configureFirebaseListeners();
  }

  @override
  void dispose() {
    taskBloc.close();
    super.dispose();
  }

  //Notifications starts here

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken() {
    _firebaseMessaging.getToken().then((token) {
      print("Device Token: $token");
    });
  }

  List<TaskSample> taskList;

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> task) async {
        print('onMessage: $task');
        _setTask(task);
      },
      onLaunch: (Map<String, dynamic> task) async {
        print('onLaunch: $task');
        _setTaskAndNavigate(task);
      },
      onResume: (Map<String, dynamic> task) async {
        print('onResume: $task');
        _setTaskAndNavigate(task);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  //TODO: Create a dialog box

  _setTask(Map<String, dynamic> task) {
    final notification = task['notification'];
    final data = task['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String taskId = data['id'];
    String from = data['from'];
    String to = data['to'];
    String containerName = data['containerName'];
    DateTime pickupTime = data['pickupTime'];
    print(
        "Title: $title, body: $body, from : $from, to: $to, taskId: $taskId, pickupTime: $pickupTime,containerName: $containerName");
    setState(() {
      TaskSample newTask =
          TaskSample(taskId, from, to, pickupTime, containerName);
      taskList.add(newTask);
    });
  }

  // this function is created to navigate user to task detail screen as soon as
  // he clicks on the notification when app is not running
  // two cases are possible
  //when user is not logged in navigate to login page
  // when user is logged in navigate to task detail page

  _setTaskAndNavigate(Map<String, dynamic> task) {
    final notification = task['notification'];
    final data = task['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String taskId = data['id'];
    String from = data['from'];
    String to = data['to'];
    String containerName = data['containerName'];
    DateTime pickupTime = data['pickupTime'];
    print(
        "Title: $title, body: $body, from : $from, to: $to, taskId: $taskId, pickupTime: $pickupTime,containerName: $containerName");
    setState(() {
      TaskSample newTask =
          TaskSample(taskId, from, to, pickupTime, containerName);
      taskList.add(newTask);
    });
    // checkif logged in or not
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TaskDetailTest(taskId, from, to, pickupTime, containerName),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Task>(
      stream: taskBloc.task(widget.taskId).where((task) => task != null),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CenteredLoading();

        final task = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text(ArchSampleLocalizations.of(context).taskDetails),
            actions: [
              IconButton(
                key: ArchSampleKeys.deleteTaskButton,
                tooltip: ArchSampleLocalizations.of(context).deleteTask,
                icon: Icon(Icons.delete),
                onPressed: () {
                  taskBloc.deleteTask.add(task.id);
                  Navigator.pop(context, task);
                },
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Checkbox(
                        value: task.complete,
                        key: ArchSampleKeys.detailsTaskItemCheckbox,
                        onChanged: (complete) {
                          taskBloc.updateTask
                              .add(task.copyWith(complete: !task.complete));
                        },
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 8.0,
                              bottom: 16.0,
                            ),
                            child: Text(
                              task.containerName,
                              key: ArchSampleKeys.detailsTaskItemContainerName,
                              style: Theme.of(context).textTheme.headline,
                            ),
                          ),
                          Text(
                            task.from,
                            key: ArchSampleKeys.detailsTaskItemFrom,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          Text(
                            ' to ',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          Text(
                            task.to,
                            key: ArchSampleKeys.detailsTaskItemTo,
                            style: Theme.of(context).textTheme.subhead,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: ArchSampleLocalizations.of(context).editTask,
            child: Icon(Icons.edit),
            key: ArchSampleKeys.editTaskFab,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddEditScreen(
                      task: task,
                      updateTask: taskBloc.updateTask.add,
                      key: ArchSampleKeys.editTaskScreen,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class TaskSample {
  String taskId;
  String from;
  String to;
  String containerName;
  DateTime pickupTime;

  TaskSample(taskId, from, to, pickupTime, containerName) {
    this.taskId = taskId;
    this.from = from;
    this.to = to;
    this.containerName = containerName;
    this.pickupTime = pickupTime;
  }
}
