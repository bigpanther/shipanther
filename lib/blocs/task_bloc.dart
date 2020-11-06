// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:shipanther/blocs/models/task.dart';
import 'package:shipanther/blocs/tasks_interactor.dart';

class TaskBloc {
  // Inputs
  final Sink<String> deleteTask;
  final Sink<Task> updateTask;

  final TasksInteractor _interactor;
  final List<StreamSubscription<dynamic>> _subscriptions;

  TaskBloc._(
    this.deleteTask,
    this.updateTask,
    this._interactor,
    this._subscriptions,
  );

  factory TaskBloc(TasksInteractor interactor) {
    final removeTaskController = StreamController<String>(sync: true);
    final updateTaskController = StreamController<Task>(sync: true);
    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user updates an item, update the repository
      updateTaskController.stream.listen(interactor.updateTask),

      // When a user removes an item, remove it from the repository
      removeTaskController.stream.listen(interactor.deleteTask),
    ];

    return TaskBloc._(
      removeTaskController,
      updateTaskController,
      interactor,
      subscriptions,
    );
  }

  Stream<Task> task(String id) {
    return _interactor.task(id);
  }

  void close() {
    deleteTask.close();
    updateTask.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}
