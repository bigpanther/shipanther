import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/terminal/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class BackOfficeHome extends StatefulWidget {
  final User user;
  const BackOfficeHome(this.user, {Key key}) : super(key: key);

  @override
  _BackOfficeHomeState createState() => _BackOfficeHomeState();
}

class _BackOfficeHomeState extends State<BackOfficeHome> {
  TerminalBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<TerminalBloc>();
    bloc.add(GetTerminal(widget.user.tenantId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TerminalBloc, TerminalState>(
      listener: (context, state) {
        if (state is TerminalFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Home()));
        }
      },
      builder: (context, state) {
        print(state);
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
