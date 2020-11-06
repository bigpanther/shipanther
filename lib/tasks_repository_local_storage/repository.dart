// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:shipanther/tasks_repository_core/tasks_repository.dart';

import 'package:shipanther/tasks_repository_core/task_entity.dart';
import 'web_client.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Tasks and Persist tasks.
class LocalStorageRepository implements TasksRepository {
  final TasksRepository localStorage;
  final TasksRepository webClient;

  const LocalStorageRepository({
    @required this.localStorage,
    this.webClient = const WebClient(),
  });

  /// Loads tasks first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Tasks from a Web Client.
  @override
  Future<List<TaskEntity>> loadTasks() async {
    try {
      return await localStorage.loadTasks();
    } catch (e) {
      final tasks = await webClient.loadTasks();

      await localStorage.saveTasks(tasks);

      return tasks;
    }
  }

  // Persists tasks to local disk and the web
  @override
  Future saveTasks(List<TaskEntity> tasks) {
    return Future.wait<dynamic>([
      localStorage.saveTasks(tasks),
      webClient.saveTasks(tasks),
    ]);
  }
}
