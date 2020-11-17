import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/terminal/terminal_bloc.dart';

import 'package:shipanther/screens/terminal/details.dart';
import 'package:shipanther/screens/terminal/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({Key key}) : super(key: key);

  @override
  _TerminalScreenState createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
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
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => TerminalScreen()));
        }
      },
      builder: (context, state) {
        print(state);
        if (state is TerminalsLoaded) {
          return TerminalList(terminalBloc: bloc, terminalLoadedState: state);
        }
        if (state is TerminalLoaded) {
          return TerminalDetail(terminalBloc: bloc, state: state);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Terminals"),
          ),
          body: CenteredLoading(),
        );
      },
    );
  }
}
