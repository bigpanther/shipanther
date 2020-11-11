import 'package:shipanther/blocs/tasks_interactor.dart';
import 'package:shipanther/blocs/tasks_list_bloc.dart';
import 'package:shipanther/dependency_injection.dart';
import 'package:shipanther/localization.dart';
import 'package:shipanther/screens/add_edit_screen.dart';
import 'package:shipanther/screens/home_screen.dart';
import 'package:shipanther/widgets/tasks_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/tasks_app_core/localization.dart';
import 'package:shipanther/tasks_app_core/theme.dart';
import 'package:shipanther/tasks_app_core/routes.dart';

class DriverHomeScreen extends StatelessWidget {
  final TasksInteractor tasksInteractor;

  const DriverHomeScreen({
    Key key,
    @required this.tasksInteractor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Injector(
      tasksInteractor: tasksInteractor,
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
              return HomeScreen();
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
