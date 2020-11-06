// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

// A poor man's DI. This should be replaced by a proper solution once they
// are more stable.
library dependency_injector;

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/blocs/tasks_interactor.dart';
import 'package:shipanther/tasks_repository_core/user_repository.dart';

class Injector extends InheritedWidget {
  final TasksInteractor tasksInteractor;
  final UserRepository userRepository;

  Injector({
    Key key,
    @required this.tasksInteractor,
    @required this.userRepository,
    @required Widget child,
  }) : super(key: key, child: child);

  static Injector of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Injector>();

  @override
  bool updateShouldNotify(Injector oldWidget) =>
      tasksInteractor != oldWidget.tasksInteractor ||
      userRepository != oldWidget.userRepository;
}
