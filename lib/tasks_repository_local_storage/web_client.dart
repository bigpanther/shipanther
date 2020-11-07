// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:shipanther/tasks_repository_core/tasks_repository.dart';
import 'package:shipanther/tasks_repository_core/task_entity.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Tasks to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient implements TasksRepository {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Tasks from a "web service" after a short delay
  @override
  Future<List<TaskEntity>> loadTasks() async {
    return Future.delayed(
        delay,
        () => [
              TaskEntity('CANC1234561', '1', 'Delta Port', 'Delta Yard 1',
                  false, DateTime.now()),
              TaskEntity('CANC1234562', '2', 'Vancouver Port', 'Delta Yard 2',
                  false, DateTime.now()),
              TaskEntity('CANC1234563', '3', 'Delta Yard 1', 'Vancouver Port',
                  true, DateTime.now()),
              TaskEntity('CANC1234564', '4', 'CANRAIL Terminal', 'Delta port',
                  false, DateTime.now()),
              TaskEntity('CANC1234565', '5', 'Delta port', 'Delta yard 3', true,
                  DateTime.now()),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  @override
  Future<bool> saveTasks(List<TaskEntity> tasks) async {
    return Future.value(true);
  }
}
