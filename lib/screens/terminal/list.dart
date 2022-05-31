import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/extensions/terminal_extension.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/locales/date_formatter.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/screens/terminal/add_edit.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:shipanther/widgets/uuid.dart';
import 'package:trober_sdk/trober_sdk.dart';

class TerminalList extends StatelessWidget {
  const TerminalList(this.loggedInUser,
      {Key? key, required this.terminalLoadedState, required this.terminalBloc})
      : super(key: key);

  final TerminalBloc terminalBloc;
  final TerminalsLoaded terminalLoadedState;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context).terminalsTitle(2);
    final actions = <Widget>[
      FilterButton<TerminalType>(
        possibleValues: TerminalType.values.toList(),
        isActive: true,
        activeFilter: terminalLoadedState.terminalType,
        onSelected: (t) => context.read<TerminalBloc>().add(
              GetTerminals(terminalType: t),
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
              leading: Icon(t.type!.icon),
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
                t.name!,
                style: Theme.of(context).textTheme.headline6,
              ),
              children: [
                displaySubtitle(ShipantherLocalizations.of(context).createdAt,
                    t.createdAt?.toLocal(),
                    formatter: dateTimeFormatter),
                displaySubtitle(ShipantherLocalizations.of(context).lastUpdate,
                    t.updatedAt?.toLocal(),
                    formatter: dateTimeFormatter),
              ],
            ),
          ),
        );
      },
    );
    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context).terminalAdd,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => TerminalAddEdit(
              loggedInUser,
              isEdit: false,
              terminalBloc: terminalBloc,
              terminal: Terminal((b) => b
                ..type = TerminalType.port
                ..id = uuid()),
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );

    return ShipantherScaffold(loggedInUser,
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
