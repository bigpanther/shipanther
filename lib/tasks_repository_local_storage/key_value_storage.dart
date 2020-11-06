// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:convert';

import 'package:key_value_store/key_value_store.dart';
import 'package:shipanther/tasks_repository_core/tasks_repository.dart';

import 'package:shipanther/tasks_repository_core/task_entity.dart';

/// Loads and saves a List of Tasks using a provided KeyValueStore, which works
/// on mobile and web. On mobile, it uses the SharedPreferences package, on web
/// it uses window.localStorage.
///
/// Can be used as it's own repository, or mixed together with other storage
/// solutions, such as the the WebClient, which can be seen in the
/// LocalStorageRepository.
class KeyValueStorage implements TasksRepository {
  final String key;
  final KeyValueStore store;
  final JsonCodec codec;

  const KeyValueStorage(this.key, this.store, [this.codec = json]);

  @override
  Future<List<TaskEntity>> loadTasks() async {
    return codec
        .decode(store.getString(key))['tasks']
        .cast<Map<String, Object>>()
        .map<TaskEntity>(TaskEntity.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> saveTasks(List<TaskEntity> tasks) {
    return store.setString(
      key,
      codec.encode({
        'tasks': tasks.map((task) => task.toJson()).toList(),
      }),
    );
  }
}
