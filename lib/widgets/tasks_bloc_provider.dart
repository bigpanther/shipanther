// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/blocs/tasks_list_bloc.dart';

class TasksBlocProvider extends StatefulWidget {
  final Widget child;
  final TasksListBloc bloc;

  TasksBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _TasksBlocProviderState createState() => _TasksBlocProviderState();

  static TasksListBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_TasksBlocProvider>()
        .bloc;
  }
}

class _TasksBlocProviderState extends State<TasksBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _TasksBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _TasksBlocProvider extends InheritedWidget {
  final TasksListBloc bloc;

  _TasksBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_TasksBlocProvider old) => bloc != old.bloc;
}
