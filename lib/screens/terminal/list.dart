import 'package:flutter/material.dart';

import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/extensions/terminal_extension.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/terminal/add_edit.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/user_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TerminalList extends StatelessWidget {
  const TerminalList(this.loggedInUser,
      {Key key, @required this.terminalLoadedState, this.terminalBloc})
      : super(key: key);

  final TerminalBloc terminalBloc;
  final TerminalsLoaded terminalLoadedState;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context).terminalsTitle(2);
    final actions = <Widget>[
      FilterButton<TerminalType>(
        possibleValues: TerminalType.values,
        isActive: true,
        activeFilter: terminalLoadedState.terminalType,
        onSelected: (t) => context.read<TerminalBloc>().add(
              GetTerminals(t),
            ),
        tooltip: ShipantherLocalizations.of(context).terminalTypeFilter,
      )
    ];

    final Widget body = ListView.builder(
      itemCount: terminalLoadedState.terminals.length,
      itemBuilder: (BuildContext context, int index) {
        final t = terminalLoadedState.terminals.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            elevation: 1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: ExpansionTile(
              childrenPadding: const EdgeInsets.only(left: 20, bottom: 10),
              leading: Icon(t.type.icon),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
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
                addColon(
                    ShipantherLocalizations.of(context).createdAt,
                    ShipantherLocalizations.of(context)
                        .dateFormatter
                        .format(t.createdAt)),
                addColon(
                    ShipantherLocalizations.of(context).lastUpdate,
                    ShipantherLocalizations.of(context)
                        .dateFormatter
                        .format(t.updatedAt)),
                if (loggedInUser.isSuperAdmin)
                  addColon(
                      ShipantherLocalizations.of(context).tenantId, t.tenantId)
                else
                  const Text(''),
              ],
            ),
          ),
        );
      },
    );
    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context).terminalAdd,
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
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
        bottomNavigationBar: null,
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
