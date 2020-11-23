import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;

class ContainerScreen extends StatefulWidget {
  final api.User user;
  ContainerScreen(this.user);
  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  ContainerBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<ContainerBloc>();
    bloc.add(GetContainers(widget.user));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContainerBloc, ContainerState>(
      builder: (context, state) {
        if (state is ContainerLoaded) {
          return Container(
            child: Text('container loaded'),
          );
        }
        if (state is ContainersLoaded) {
          return Container(
            child: RaisedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogout());
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => SignInOrRegistrationPage()));
              },
            ),
          );
        }
        return ShipantherScaffold(
          widget.user,
          title: ShipantherLocalizations.of(context).containersTitle,
          actions: [],
          body: CenteredLoading(),
          floatingActionButton: null,
        );
      },
      listener: (context, state) {
        if (state is ContainerFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
    );
  }
}
