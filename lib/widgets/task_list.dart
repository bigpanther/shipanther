// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:shipanther/blocs/models/task.dart';
import 'package:shipanther/blocs/task_bloc.dart';
import 'package:shipanther/dependency_injection.dart';
import 'package:shipanther/screens/detail_screen.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/task_item.dart';
import 'package:shipanther/widgets/tasks_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/tasks_app_core/localization.dart';
import 'package:shipanther/tasks_app_core/keys.dart';

class TaskList extends StatelessWidget {
  TaskList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: TasksBlocProvider.of(context).visibleTasks,
      builder: (context, snapshot) => snapshot.hasData
          ? _buildList(snapshot.data)
          : CenteredLoading(key: ArchSampleKeys.tasksLoading),
    );
  }

  ListView _buildList(List<Task> tasks) {
    return ListView.builder(
      key: ArchSampleKeys.taskList,
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        final task = tasks[index];

        return TaskItem(
          task: task,
          onDismissed: (direction) {
            _removeTask(context, task);
          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return DetailScreen(
                    taskId: task.id,
                    initBloc: () =>
                        TaskBloc(Injector.of(context).tasksInteractor),
                  );
                },
              ),
            ).then((task) {
              if (task is Task) {
                _showUndoSnackbar(context, task);
              }
            });
          },
          onCheckboxChanged: (complete) {
            TasksBlocProvider.of(context)
                .updateTask
                .add(task.copyWith(complete: !task.complete));
          },
        );
      },
    );
  }

  void _removeTask(BuildContext context, Task task) {
    TasksBlocProvider.of(context).deleteTask.add(task.id);

    _showUndoSnackbar(context, task);
  }

  void _showUndoSnackbar(BuildContext context, Task task) {
    final snackBar = SnackBar(
      key: ArchSampleKeys.snackbar,
      duration: Duration(seconds: 2),
      content: Text(
        ArchSampleLocalizations.of(context).taskDeleted(task.containerName),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      action: SnackBarAction(
        key: ArchSampleKeys.snackbarAction(task.id),
        label: ArchSampleLocalizations.of(context).undo,
        onPressed: () {
          TasksBlocProvider.of(context).addTask.add(task);
        },
      ),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
