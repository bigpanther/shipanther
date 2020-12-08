import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/terminal/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class DriverHome extends StatefulWidget {
  final User user;
  const DriverHome(this.user, {Key key}) : super(key: key);

  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  TerminalBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<TerminalBloc>();
    bloc.add(GetTerminals(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TerminalBloc, TerminalState>(
      listener: (context, state) {
        if (state is TerminalFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is TerminalsLoaded) {
          return TerminalList(widget.user,
              terminalBloc: bloc, terminalLoadedState: state);
        }
        return ShipantherScaffold(
          widget.user,
          title: ShipantherLocalizations.of(context).tenantsTitle,
          actions: [],
          body: CenteredLoading(),
          floatingActionButton: null,
        );
      },
    );
  }
}
