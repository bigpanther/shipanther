// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:shipanther/blocs/models/visibility_filter.dart';
import 'package:shipanther/blocs/stats_bloc.dart';
import 'package:shipanther/blocs/tasks_list_bloc.dart';
import 'package:shipanther/dependency_injection.dart';
import 'package:shipanther/localization.dart';
import 'package:shipanther/tasks_app_core/keys.dart';
import 'package:shipanther/tasks_app_core/localization.dart';
import 'package:shipanther/tasks_app_core/routes.dart';
import 'package:shipanther/widgets/extra_actions_button.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/loading.dart';
import 'package:shipanther/widgets/stats_counter.dart';
import 'package:shipanther/widgets/task_list.dart';
import 'package:shipanther/widgets/tasks_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum AppTab { tasks, stats }

class HomeScreen extends StatefulWidget {
  HomeScreen() : super(key: ArchSampleKeys.homeScreen);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  StreamController<AppTab> tabController;

  @override
  void initState() {
    super.initState();

    tabController = StreamController<AppTab>();
  }

  @override
  void dispose() {
    tabController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksBloc = TasksBlocProvider.of(context);

    return StreamBuilder<AppTab>(
      initialData: AppTab.tasks,
      stream: tabController.stream,
      builder: (context, activeTabSnapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(BlocLocalizations.of(context).appTitle),
            actions: _buildActions(
              tasksBloc,
              activeTabSnapshot,
              true,
            ),
          ),
          body: true
              ? activeTabSnapshot.data == AppTab.tasks
                  ? TaskList()
                  : StatsCounter(
                      buildBloc: () =>
                          StatsBloc(Injector.of(context).tasksInteractor),
                    )
              : LoadingSpinner(
                  key: ArchSampleKeys.tasksLoading,
                ),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addTaskFab,
            onPressed: () {
              Navigator.pushNamed(context, ArchSampleRoutes.addTask);
            },
            child: Icon(Icons.add),
            tooltip: ArchSampleLocalizations.of(context).addTask,
          ),
          bottomNavigationBar: BottomNavigationBar(
            key: ArchSampleKeys.tabs,
            currentIndex: AppTab.values.indexOf(activeTabSnapshot.data),
            onTap: (index) {
              tabController.add(AppTab.values[index]);
            },
            items: AppTab.values.map((tab) {
              return BottomNavigationBarItem(
                icon: Icon(
                  tab == AppTab.tasks ? Icons.list : Icons.show_chart,
                  key: tab == AppTab.stats
                      ? ArchSampleKeys.statsTab
                      : ArchSampleKeys.taskTab,
                ),
                title: Text(
                  tab == AppTab.stats
                      ? ArchSampleLocalizations.of(context).stats
                      : ArchSampleLocalizations.of(context).tasks,
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  List<Widget> _buildActions(
    TasksListBloc tasksBloc,
    AsyncSnapshot<AppTab> activeTabSnapshot,
    bool hasData,
  ) {
    if (!hasData) return [];

    return [
      StreamBuilder<VisibilityFilter>(
        stream: tasksBloc.activeFilter,
        builder: (context, snapshot) {
          return FilterButton(
            isActive: activeTabSnapshot.data == AppTab.tasks,
            activeFilter: snapshot.data ?? VisibilityFilter.all,
            onSelected: tasksBloc.updateFilter.add,
          );
        },
      ),
      StreamBuilder<ExtraActionsButtonViewModel>(
        stream: Rx.combineLatest2(
          tasksBloc.allComplete,
          tasksBloc.hasCompletedTasks,
          (allComplete, hasCompletedTasks) {
            return ExtraActionsButtonViewModel(
              allComplete,
              hasCompletedTasks,
            );
          },
        ),
        builder: (context, snapshot) {
          return ExtraActionsButton(
            allComplete: snapshot.data?.allComplete ?? false,
            hasCompletedTasks: snapshot.data?.hasCompletedTasks ?? false,
            onSelected: (action) {
              if (action == ExtraAction.toggleAllComplete) {
                tasksBloc.toggleAll.add(null);
              } else if (action == ExtraAction.clearCompleted) {
                tasksBloc.clearCompleted.add(null);
              }
            },
          );
        },
      )
    ];
  }
}
