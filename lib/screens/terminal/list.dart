import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/extensions/terminal_extension.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/terminal/add_edit.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TerminalList extends StatelessWidget {
  final TerminalBloc terminalBloc;
  final TerminalsLoaded terminalLoadedState;
  final User loggedInUser;
  const TerminalList(this.loggedInUser,
      {Key key, @required this.terminalLoadedState, this.terminalBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
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
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.only(left: 20, bottom: 10),
              // subtitle: Text(t.id),
              // tilePadding: EdgeInsets.all(5),
              leading: Icon(t.type.icon),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TerminalAddEdit(
                        loggedInUser,
                        isEdit: true,
                        terminalBloc: terminalBloc,
                        terminal: t,
                      ),
                    ),
                  );
                },
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              title: Text(
                t.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              children: [
                Text(
                  "Created At: ${formatter.format(t.createdAt).toString()}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Created By: ${t.createdBy}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Last Update: ${formatter.format(t.updatedAt).toString()}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Tenant ID: ${t.tenantId}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
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
              loggedInUser,
              isEdit: false,
              terminalBloc: terminalBloc,
              terminal: Terminal(),
            ),
          ),
        );
      },
    );

    return ShipantherScaffold(loggedInUser,
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
