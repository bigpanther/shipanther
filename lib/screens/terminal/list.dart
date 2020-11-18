import 'package:flutter/material.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/terminal/add_edit.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TerminalList extends StatelessWidget {
  final TerminalBloc terminalBloc;
  final TerminalsLoaded terminalLoadedState;
  const TerminalList(
      {Key key, @required this.terminalLoadedState, this.terminalBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = ShipantherLocalizations.of(context).terminalsTitle;
    List<Widget> actions = [
      FilterButton<TerminalType>(
        possibleValues: TerminalType.values,
        isActive: true,
        activeFilter: terminalLoadedState.terminalType,
        onSelected: (t) => context.read<TerminalBloc>()..add(GetTerminals(t)),
        tooltip: "Filter Terminal type",
      )
    ];
    Widget body = ListView.builder(
      itemCount: terminalLoadedState.terminals.length,
      itemBuilder: (BuildContext context, int index) {
        var t = terminalLoadedState.terminals.elementAt(index);
        return ListTile(
          onTap: () => terminalBloc.add(GetTerminal(t.id)),
          title: Text(
            t.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            "Created: ${t.createdAt}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        );
      },
    );
    Widget floatingActionButton = FloatingActionButton(
      tooltip: "Add terminal",
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TerminalAddEdit(
              isEdit: false,
              terminalBloc: terminalBloc,
              terminal: Terminal(),
            ),
          ),
        );
      },
    );

    return ShipantherScaffold(
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
