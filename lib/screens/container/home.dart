import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/container/add_edit.dart';
import 'package:shipanther/screens/container/driver_list.dart';
import 'package:shipanther/screens/container/list.dart';

import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:shipanther/extensions/user_extension.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen(this.loggedInUser);
  final api.User loggedInUser;
  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  ContainerBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<ContainerBloc>();
    bloc.add(const GetContainers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContainerBloc, ContainerState>(
      listener: (context, state) {
        if (state is ContainerFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
        if (state is ContainerLoaded) {
          Navigator.of(context).push(
            MaterialPageRoute<Widget>(
              builder: (_) => ContainerAddEdit(
                widget.loggedInUser,
                isEdit: true,
                containerBloc: bloc,
                container: state.container,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ContainersLoaded) {
          return widget.loggedInUser.isDriver
              ? DriverContainerList(widget.loggedInUser,
                  containerBloc: bloc, containerLoadedState: state)
              : ContainerList(widget.loggedInUser,
                  containerBloc: bloc, containerLoadedState: state);
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
