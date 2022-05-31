import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/screens/terminal/list.dart';
import 'package:shipanther/widgets/loading_widget.dart';
import 'package:trober_sdk/trober_sdk.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen(this.loggedInUser, {Key? key}) : super(key: key);

  final User loggedInUser;

  @override
  TerminalScreenState createState() => TerminalScreenState();
}

class TerminalScreenState extends State<TerminalScreen> {
  late TerminalBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<TerminalBloc>();
    bloc.add(const GetTerminals());
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
        return LoadingWidget(
            loggedInUser: widget.loggedInUser,
            title: ShipantherLocalizations.of(context).terminalsTitle(2));
      },
    );
  }
}
