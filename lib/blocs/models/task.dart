// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:shipanther/tasks_app_core/uuid.dart';
import 'package:shipanther/tasks_repository_core/task_entity.dart';

@immutable
class Task {
  final bool complete;
  final String id;
  final String containerName;
  final String from;
  final String to;
  final DateTime pickingTime;

  Task(this.containerName, this.pickingTime,
      {this.complete = false, String from = '', String to = '', String id})
      : this.from = from ?? '',
        this.to = to ?? '',
        this.id = id ?? Uuid().generateV4();

  Task copyWith(
      {bool complete,
      String id,
      String containerName,
      String from,
      String to,
      DateTime pickingTime}) {
    return Task(
      containerName ?? this.containerName,
      pickingTime ?? this.pickingTime,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^
      containerName.hashCode ^
      from.hashCode ^
      to.hashCode ^
      id.hashCode ^
      pickingTime.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          containerName == other.containerName &&
          from == other.from &&
          to == other.to &&
          id == other.id &&
          pickingTime == other.pickingTime;

  @override
  String toString() {
    return 'Task{complete: $complete, containerName: $containerName, from: $from, to: $to, id: $id,pickingTime: $pickingTime}';
  }

  TaskEntity toEntity() {
    return TaskEntity(containerName, id, from, to, complete, pickingTime);
  }

  static Task fromEntity(TaskEntity entity) {
    return Task(
      entity.containerName,
      entity.pickingTime,
      complete: entity.complete ?? false,
      from: entity.from,
      to: entity.to,
      id: entity.id ?? Uuid().generateV4(),
    );
  }
}
