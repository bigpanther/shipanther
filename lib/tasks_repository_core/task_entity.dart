// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

class TaskEntity {
  final bool complete;
  final String id;
  final String from;
  final String to;
  final String containerName;
  final DateTime pickingTime;

  TaskEntity(this.containerName, this.id, this.from, this.to, this.complete,
      this.pickingTime);

  @override
  int get hashCode =>
      complete.hashCode ^
      containerName.hashCode ^
      from.hashCode ^
      to.hashCode ^
      id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEntity &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          containerName == other.containerName &&
          from == other.from &&
          to == other.to &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'containerName': containerName,
      'from': from,
      'to': to,
      'id': id,
      'pickingTime': pickingTime
    };
  }

  @override
  String toString() {
    return 'TaskEntity{complete: $complete, containerName: $containerName, from: $from, to: $to, id: $id,pickingTime: $pickingTime}';
  }

  static TaskEntity fromJson(Map<String, Object> json) {
    return TaskEntity(
        json['containerName'] as String,
        json['id'] as String,
        json['from'] as String,
        json['to'] as String,
        json['complete'] as bool,
        json['pickingTime'] as DateTime);
  }
}
