// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/blocs/models/task.dart';
import 'package:shipanther/tasks_app_core/keys.dart';

class TaskItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Task task;

  TaskItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.taskItem(task.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          key: ArchSampleKeys.taskItemCheckbox(task.id),
          value: task.complete,
          onChanged: onCheckboxChanged,
        ),
        title: Text(
          task.containerName,
          key: ArchSampleKeys.taskItemContainerName(task.id),
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          "${task.from} to ${task.to}",
          key: ArchSampleKeys.taskItemFrom(task.id),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }
}
