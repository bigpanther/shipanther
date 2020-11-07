// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:shipanther/blocs/models/task.dart';
import 'package:shipanther/blocs/task_bloc.dart';
import 'package:shipanther/screens/add_edit_screen.dart';
import 'package:shipanther/tasks_app_core/keys.dart';
import 'package:shipanther/tasks_app_core/localization.dart';
import 'package:shipanther/widgets/loading.dart';
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
  }

  @override
  void dispose() {
    taskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Task>(
      stream: taskBloc.task(widget.taskId).where((task) => task != null),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoadingSpinner();

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
                          ),
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
