// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:shipanther/blocs/models/task.dart';
import 'package:shipanther/tasks_repository_core/reactive_repository.dart';

class TasksInteractor {
  final ReactiveTasksRepository repository;

  TasksInteractor(this.repository);

  Stream<List<Task>> get tasks {
    return repository.tasks().map((entities) {
      return entities.map(Task.fromEntity).toList();
    });
  }

  Stream<Task> task(String id) {
    return tasks.map((tasks) {
      return tasks.firstWhere(
        (task) => task.id == id,
        orElse: () => null,
      );
    }).where((task) => task != null);
  }

  Stream<bool> get allComplete => tasks.map(_allComplete);

  Stream<bool> get hasCompletedTasks => tasks.map(_hasCompletedTasks);

  Future<void> updateTask(Task task) => repository.updateTask(task.toEntity());

  Future<void> addNewTask(Task task) => repository.addNewTask(task.toEntity());

  Future<void> deleteTask(String id) => repository.deleteTask([id]);

  Future<void> clearCompleted([_]) async =>
      repository.deleteTask(await tasks.map(_completedTaskIds).first);

  Future<List<dynamic>> toggleAll([_]) async {
    final updates = await tasks.map(_tasksToUpdate).first;

    return Future.wait(
        updates.map((update) => repository.updateTask(update.toEntity())));
  }

  static bool _hasCompletedTasks(List<Task> tasks) {
    return tasks.any((task) => task.complete);
  }

  static List<String> _completedTaskIds(List<Task> tasks) {
    return tasks.fold<List<String>>([], (prev, task) {
      if (task.complete) {
        return prev..add(task.id);
      } else {
        return prev;
      }
    });
  }

  static List<Task> _tasksToUpdate(List<Task> tasks) {
    final allComplete = _allComplete(tasks);

    return tasks.fold<List<Task>>([], (prev, task) {
      if (allComplete) {
        return prev..add(task.copyWith(complete: false));
      } else if (!allComplete && !task.complete) {
        return prev..add(task.copyWith(complete: true));
      } else {
        return prev;
      }
    });
  }

  static bool _allComplete(List<Task> tasks) =>
      tasks.every((task) => task.complete);
}
