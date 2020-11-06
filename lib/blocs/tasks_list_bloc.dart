// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shipanther/blocs/models/task.dart';
import 'package:shipanther/blocs/models/visibility_filter.dart';
import 'package:shipanther/blocs/tasks_interactor.dart';

class TasksListBloc {
  // Inputs
  final Sink<Task> addTask;
  final Sink<String> deleteTask;
  final Sink<VisibilityFilter> updateFilter;
  final Sink<void> clearCompleted;
  final Sink<void> toggleAll;
  final Sink<Task> updateTask;

  // Outputs
  final Stream<VisibilityFilter> activeFilter;
  final Stream<bool> allComplete;
  final Stream<bool> hasCompletedTasks;
  final Stream<List<Task>> visibleTasks;

  // Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  factory TasksListBloc(TasksInteractor interactor) {
    // We'll use a series of StreamControllers to glue together our inputs and
    // outputs.
    //
    // StreamControllers have both a Sink and a Stream. We'll expose the Sinks
    // publicly so users can send information to the Bloc. We'll use the Streams
    // internally to react to that user input.
    final addTaskController = StreamController<Task>(sync: true);
    final clearCompletedController = PublishSubject<void>(sync: true);
    final deleteTaskController = StreamController<String>(sync: true);
    final toggleAllController = PublishSubject<void>(sync: true);
    final updateTaskController = StreamController<Task>(sync: true);
    final updateFilterController = BehaviorSubject<VisibilityFilter>.seeded(
      VisibilityFilter.all,
      sync: true,
    );

    // In some cases, we need to simply route user interactions to our data
    // layer. In this case, we'll listen to the streams. In order to clean
    // these subscriptions up, we'll pop them in a list and ensure we cancel
    // all of them in the `close` method when they are no longer needed.
    final subscriptions = <StreamSubscription<dynamic>>[
      // When a user updates an item, update the repository
      updateTaskController.stream.listen(interactor.updateTask),
      // When a user adds an item, add it to the repository
      addTaskController.stream.listen(interactor.addNewTask),
      // When a user removes an item, remove it from the repository
      deleteTaskController.stream.listen(interactor.deleteTask),
      // When a user clears the completed items, convert the current list of
      // tasks into a list of ids, then send that to the repository
      clearCompletedController.stream.listen(interactor.clearCompleted),
      // When a user toggles all tasks, calculate whether all tasks should be
      // marked complete or incomplete and push the change to the repository
      toggleAllController.stream.listen(interactor.toggleAll),
    ];

    // To calculate the visible tasks, we combine the tasks with the current
    // visibility filter and return the filtered tasks.
    //
    // Every time the tasks or the filter changes the visible items will emit
    // once again. We also convert the normal Stream into a BehaviorSubject
    // so the Stream can be listened to multiple times
    final visibleTasksController = BehaviorSubject<List<Task>>();

    Rx.combineLatest2<List<Task>, VisibilityFilter, List<Task>>(
      interactor.tasks,
      updateFilterController.stream,
      _filterTasks,
    ).pipe(visibleTasksController);

    return TasksListBloc._(
      addTaskController,
      deleteTaskController,
      updateFilterController,
      clearCompletedController,
      toggleAllController,
      updateTaskController,
      visibleTasksController.stream,
      interactor.allComplete,
      interactor.hasCompletedTasks,
      updateFilterController.stream,
      subscriptions,
    );
  }

  TasksListBloc._(
    this.addTask,
    this.deleteTask,
    this.updateFilter,
    this.clearCompleted,
    this.toggleAll,
    this.updateTask,
    this.visibleTasks,
    this.allComplete,
    this.hasCompletedTasks,
    this.activeFilter,
    this._subscriptions,
  );

  static List<Task> _filterTasks(List<Task> tasks, VisibilityFilter filter) {
    return tasks.where((task) {
      switch (filter) {
        case VisibilityFilter.active:
          return !task.complete;
        case VisibilityFilter.completed:
          return task.complete;
        case VisibilityFilter.all:
        default:
          return true;
      }
    }).toList();
  }

  // This method should close down all sinks and cancel all stream
  // subscriptions. This ensures we free up resources and don't trigger odd
  // bugs.
  void close() {
    addTask.close();
    deleteTask.close();
    updateFilter.close();
    clearCompleted.close();
    toggleAll.close();
    updateTask.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}
