import 'package:flutter/material.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/screens/terminal/add_edit.dart';

class TerminalDetail extends StatelessWidget {
  final TerminalLoaded state;
  final TerminalBloc terminalBloc;

  const TerminalDetail({Key key, this.state, this.terminalBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terminal Details"),
        actions: [
          IconButton(
            tooltip: "Delete Terminal",
            icon: Icon(Icons.delete),
            onPressed: () {
              // context
              //     .read<TenantBloc>()
              //     .add(DeleteTenant(state.tenant.id));
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: 16.0,
                        ),
                        child: Text(
                          state.terminal.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Text(
                        'Id  ${state.terminal.id}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Created At  ${state.terminal.createdAt}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Type  ${state.terminal.type}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Updated At  ${state.terminal.updatedAt}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        'Created By  ${state.terminal.createdBy}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Edit terminal",
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TerminalAddEdit(
                isEdit: true,
                terminalBloc: terminalBloc,
                terminal: state.terminal,
              ),
            ),
          );
        },
      ),
    );
  }
}
