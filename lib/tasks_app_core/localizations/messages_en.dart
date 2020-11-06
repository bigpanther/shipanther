// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent = void Function(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'en';

  static String m0(task) => 'Deleted "${task}"';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'activeTasks': MessageLookupByLibrary.simpleMessage('Active Tasks'),
        'addTask': MessageLookupByLibrary.simpleMessage('Add Task'),
        'cancel': MessageLookupByLibrary.simpleMessage('Cancel'),
        'clearCompleted':
            MessageLookupByLibrary.simpleMessage('Clear completed'),
        'completedTasks':
            MessageLookupByLibrary.simpleMessage('Completed Tasks'),
        'delete': MessageLookupByLibrary.simpleMessage('Delete'),
        'deleteTask': MessageLookupByLibrary.simpleMessage('Delete Task'),
        'deleteTaskConfirmation':
            MessageLookupByLibrary.simpleMessage('Delete this task?'),
        'editTask': MessageLookupByLibrary.simpleMessage('Edit Task'),
        'emptyTaskError':
            MessageLookupByLibrary.simpleMessage('Please enter some text'),
        'filterTasks': MessageLookupByLibrary.simpleMessage('Filter Tasks'),
        'markAllComplete':
            MessageLookupByLibrary.simpleMessage('Mark all complete'),
        'markAllIncomplete':
            MessageLookupByLibrary.simpleMessage('Mark all incomplete'),
        'containerNameHint':
            MessageLookupByLibrary.simpleMessage('Container name'),
        'fromHint': MessageLookupByLibrary.simpleMessage('From'),
        'toHint': MessageLookupByLibrary.simpleMessage('To'),
        'saveChanges': MessageLookupByLibrary.simpleMessage('Save changes'),
        'showActive': MessageLookupByLibrary.simpleMessage('Show Active'),
        'showAll': MessageLookupByLibrary.simpleMessage('Show All'),
        'showCompleted': MessageLookupByLibrary.simpleMessage('Show Completed'),
        'stats': MessageLookupByLibrary.simpleMessage('Stats'),
        'taskDeleted': m0,
        'taskDetails': MessageLookupByLibrary.simpleMessage('Task Details'),
        'tasks': MessageLookupByLibrary.simpleMessage('Tasks'),
        'undo': MessageLookupByLibrary.simpleMessage('Undo')
      };
}
