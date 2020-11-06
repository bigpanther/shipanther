// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:shipanther/blocs/tasks_interactor.dart';

import 'models/task.dart';

class StatsBloc {
  final Stream<int> numActive;
  final Stream<int> numComplete;

  StatsBloc._(
    this.numActive,
    this.numComplete,
  );

  factory StatsBloc(TasksInteractor interactor) {
    return StatsBloc._(
      interactor.tasks.map(_numActive),
      interactor.tasks.map(_numComplete),
    );
  }

  static int _numActive(List<Task> tasks) {
    return tasks.fold(0, (sum, task) => !task.complete ? ++sum : sum);
  }

  static int _numComplete(List<Task> tasks) {
    return tasks.fold(0, (sum, task) => task.complete ? ++sum : sum);
  }
}
