// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'localizations/messages_all.dart';

class ArchSampleLocalizations {
  ArchSampleLocalizations(this.locale);

  final Locale locale;

  static Future<ArchSampleLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return ArchSampleLocalizations(locale);
    });
  }

  static ArchSampleLocalizations of(BuildContext context) {
    return Localizations.of<ArchSampleLocalizations>(
        context, ArchSampleLocalizations);
  }

  String get tasks => Intl.message(
        'Tasks',
        name: 'tasks',
        args: [],
        locale: locale.toString(),
      );

  String get stats => Intl.message(
        'Stats',
        name: 'stats',
        args: [],
        locale: locale.toString(),
      );

  String get showAll => Intl.message(
        'Show All',
        name: 'showAll',
        args: [],
        locale: locale.toString(),
      );

  String get showActive => Intl.message(
        'Show Active',
        name: 'showActive',
        args: [],
        locale: locale.toString(),
      );

  String get showCompleted => Intl.message(
        'Show Completed',
        name: 'showCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get containerNameHint => Intl.message(
        'Container name',
        name: 'containerName',
        args: [],
        locale: locale.toString(),
      );

  String get markAllComplete => Intl.message(
        'Mark all complete',
        name: 'markAllComplete',
        args: [],
        locale: locale.toString(),
      );

  String get markAllIncomplete => Intl.message(
        'Mark all incomplete',
        name: 'markAllIncomplete',
        args: [],
        locale: locale.toString(),
      );

  String get clearCompleted => Intl.message(
        'Clear completed',
        name: 'clearCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get addTask => Intl.message(
        'Add Task',
        name: 'addTask',
        args: [],
        locale: locale.toString(),
      );

  String get editTask => Intl.message(
        'Edit Task',
        name: 'editTask',
        args: [],
        locale: locale.toString(),
      );

  String get saveChanges => Intl.message(
        'Save changes',
        name: 'saveChanges',
        args: [],
        locale: locale.toString(),
      );

  String get filterTasks => Intl.message(
        'Filter Tasks',
        name: 'filterTasks',
        args: [],
        locale: locale.toString(),
      );

  String get deleteTask => Intl.message(
        'Delete Task',
        name: 'deleteTask',
        args: [],
        locale: locale.toString(),
      );

  String get taskDetails => Intl.message(
        'Task Details',
        name: 'taskDetails',
        args: [],
        locale: locale.toString(),
      );

  String get emptyTaskError => Intl.message(
        'Please enter some text',
        name: 'emptyTaskError',
        args: [],
        locale: locale.toString(),
      );

  String get fromHint => Intl.message(
        'From',
        name: 'from',
        args: [],
        locale: locale.toString(),
      );
  String get toHint => Intl.message(
        'To',
        name: 'to',
        args: [],
        locale: locale.toString(),
      );

  String get completedTasks => Intl.message(
        'Completed Tasks',
        name: 'completedTasks',
        args: [],
        locale: locale.toString(),
      );

  String get activeTasks => Intl.message(
        'Active Tasks',
        name: 'activeTasks',
        args: [],
        locale: locale.toString(),
      );

  String taskDeleted(String task) => Intl.message(
        'Deleted "$task"',
        name: 'taskDeleted',
        args: [task],
        locale: locale.toString(),
      );

  String get undo => Intl.message(
        'Undo',
        name: 'undo',
        args: [],
        locale: locale.toString(),
      );

  String get deleteTaskConfirmation => Intl.message(
        'Delete this task?',
        name: 'deleteTaskConfirmation',
        args: [],
        locale: locale.toString(),
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        args: [],
        locale: locale.toString(),
      );

  String get cancel => Intl.message(
        'Cancel',
        name: 'cancel',
        args: [],
        locale: locale.toString(),
      );
}

class ArchSampleLocalizationsDelegate
    extends LocalizationsDelegate<ArchSampleLocalizations> {
  @override
  Future<ArchSampleLocalizations> load(Locale locale) =>
      ArchSampleLocalizations.load(locale);

  @override
  bool shouldReload(ArchSampleLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains('en');
}
