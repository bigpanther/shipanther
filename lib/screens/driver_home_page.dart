// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipanther/blocs/tasks_interactor.dart';
import 'package:shipanther/blocs/tasks_list_bloc.dart';
import 'package:shipanther/dependency_injection.dart';
import 'package:shipanther/localization.dart';
import 'package:shipanther/screens/add_edit_screen.dart';
import 'package:shipanther/screens/home_screen.dart';
import 'package:shipanther/tasks_repository_core/user_entity.dart';
import 'package:shipanther/tasks_repository_local_storage/key_value_storage.dart';
import 'package:shipanther/tasks_repository_local_storage/reactive_repository.dart';
import 'package:shipanther/tasks_repository_local_storage/repository.dart';
import 'package:shipanther/widgets/tasks_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/tasks_app_core/localization.dart';
import 'package:shipanther/tasks_app_core/theme.dart';
import 'package:shipanther/tasks_app_core/routes.dart';
import 'package:shipanther/tasks_repository_core/user_repository.dart';

class DriverHomeScreen extends StatelessWidget {
  final TasksInteractor tasksInteractor = TasksInteractor(
    ReactiveLocalStorageRepository(
      repository: LocalStorageRepository(
        localStorage: KeyValueStorage(
          'bloc_tasks',
          FlutterKeyValueStore(await SharedPreferences.getInstance()),
        ),
      ),
    ),
  );

  final UserRepository userRepository = AnonymousUserRepository();

  @override
  Widget build(BuildContext context) {
    return Injector(
      tasksInteractor: tasksInteractor,
      userRepository: userRepository,
      child: TasksBlocProvider(
        bloc: TasksListBloc(tasksInteractor),
        child: MaterialApp(
          onGenerateTitle: (context) => BlocLocalizations.of(context).appTitle,
          theme: ArchSampleTheme.theme,
          localizationsDelegates: [
            ArchSampleLocalizationsDelegate(),
            InheritedWidgetLocalizationsDelegate(),
          ],
          routes: {
            ArchSampleRoutes.home: (context) {
              return HomeScreen(
                repository: Injector.of(context).userRepository,
              );
            },
            ArchSampleRoutes.addTask: (context) {
              return AddEditScreen(
                addTask: TasksBlocProvider.of(context).addTask.add,
              );
            },
          },
        ),
      ),
    );
  }
}

class AnonymousUserRepository implements UserRepository {
  @override
  Future<UserEntity> login() {
    return Future.value(UserEntity(id: 'anonymous'));
  }
}
