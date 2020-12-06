import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:shipanther/extensions/user_extension.dart';
import 'package:shipanther/extensions/terminal_extension.dart';

class TerminalAddEdit extends StatefulWidget {
  final api.User loggedInUser;
  final api.Terminal terminal;
  final TerminalBloc terminalBloc;
  final bool isEdit;

  TerminalAddEdit(
    this.loggedInUser, {
    Key key,
    @required this.terminal,
    @required this.terminalBloc,
    @required this.isEdit,
  });

  @override
  _TerminalAddEditState createState() => _TerminalAddEditState();
}

class _TerminalAddEditState extends State<TerminalAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _terminalName;
  api.TerminalType _terminalType;
  api.Tenant _tenant;
  final TextEditingController _tenantTypeAheadController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? "Edit terminal" : "Add new terminal",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(
            children: [
                  TextFormField(
                    initialValue: widget.terminal.name ?? '',
                    autofocus: widget.isEdit ? false : true,
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(hintText: 'Terminal Name'),
                    validator: (val) => val.trim().isEmpty
                        ? "Terminal name should not be empty"
                        : null,
                    onSaved: (value) => _terminalName = value,
                  ),
                  smartSelect<api.TerminalType>(
                    title: "Terminal type",
                    onChange: (state) => _terminalType = state.value,
                    choiceItems:
                        S2Choice.listFrom<api.TerminalType, api.TerminalType>(
                      source: api.TerminalType.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: widget.terminal.type ?? api.TerminalType.port,
                  ),
                  // Hack to avoid runtime type mismatch.
                  Container(width: 0.0, height: 0.0),
                ] +
                tenantSelector(
                    context, widget.isEdit && widget.loggedInUser.isSuperAdmin,
                    (api.Tenant suggestion) {
                  _tenant = suggestion;
                }, _tenantTypeAheadController),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit
            ? ShipantherLocalizations.of(context).edit
            : ShipantherLocalizations.of(context).create,
        child: Icon(widget.isEdit ? Icons.check : Icons.add),
        onPressed: () async {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            widget.terminal.name = _terminalName;
            widget.terminal.type = _terminalType ?? api.TerminalType.port;
            if (_tenant != null) {
              widget.terminal.tenantId = _tenant.id;
            }
            widget.terminal.createdBy =
                (await context.read<UserRepository>().self()).id;
            if (widget.isEdit) {
              widget.terminalBloc
                  .add(UpdateTerminal(widget.terminal.id, widget.terminal));
            } else {
              widget.terminalBloc.add(CreateTerminal(widget.terminal));
            }

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
