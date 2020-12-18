import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/container/driver_list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class DriverHome extends StatefulWidget {
  const DriverHome(this.loggedInUser, {Key key}) : super(key: key);
  final User loggedInUser;

  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  ContainerBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<ContainerBloc>();
    bloc.add(const GetContainers(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContainerBloc, ContainerState>(
      listener: (context, state) {
        if (state is ContainerFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is ContainersLoaded) {
          return DriverContainerList(
            widget.loggedInUser,
            containerLoadedState: state,
            containerBloc: bloc,
          );
        }
        return ShipantherScaffold(
          widget.loggedInUser,
          bottomNavigationBar: null,
          title: ShipantherLocalizations.of(context).containersTitle,
          actions: const [],
          body: const CenteredLoading(),
          floatingActionButton: null,
        );
      },
    );
  }
}
