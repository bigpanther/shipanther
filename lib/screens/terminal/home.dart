import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/terminal/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:trober_sdk/api.dart' as api;

class TerminalScreen extends StatefulWidget {
  const TerminalScreen(this.loggedInUser, {Key? key}) : super(key: key);

  final api.User loggedInUser;

  @override
  _TerminalScreenState createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  late TerminalBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<TerminalBloc>();
    bloc.add(const GetTerminals(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TerminalBloc, TerminalState>(
      listener: (context, state) {
        if (state is TerminalFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is TerminalsLoaded) {
          return TerminalList(widget.loggedInUser,
              terminalBloc: bloc, terminalLoadedState: state);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(ShipantherLocalizations.of(context).terminalsTitle(2)),
          ),
          body: const CenteredLoading(),
        );
      },
    );
  }
}
