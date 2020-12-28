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
  const TerminalAddEdit(
    this.loggedInUser, {
    required this.terminal,
    required this.terminalBloc,
    required this.isEdit,
  });

  final api.User loggedInUser;
  final api.Terminal terminal;
  final TerminalBloc terminalBloc;
  final bool isEdit;

  @override
  _TerminalAddEditState createState() => _TerminalAddEditState();
}

class _TerminalAddEditState extends State<TerminalAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();

  api.TerminalType? _terminalType;
  api.Tenant? _tenant;
  final TextEditingController _tenantTypeAheadController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _tenantTypeAheadController.text = widget.terminal.tenantId;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? ShipantherLocalizations.of(context)!.editParam(
                  ShipantherLocalizations.of(context)!.terminalsTitle(1))
              : ShipantherLocalizations.of(context)!.addNewParam(
                  ShipantherLocalizations.of(context)!.terminalsTitle(1)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    autofocus: !widget.isEdit,
                    style: Theme.of(context).textTheme.headline5,
                    controller: _name,
                    decoration: InputDecoration(
                        hintText:
                            ShipantherLocalizations.of(context)!.terminalName),
                    validator: (val) => val == null || val.trim().isEmpty
                        ? ShipantherLocalizations.of(context)!.paramEmpty(
                            ShipantherLocalizations.of(context)!.terminalName)
                        : null,
                  ),
                  smartSelect<api.TerminalType>(
                    title: ShipantherLocalizations.of(context)!.terminalType,
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
            ? ShipantherLocalizations.of(context)!.edit
            : ShipantherLocalizations.of(context)!.create,
        child: Icon(widget.isEdit ? Icons.check : Icons.add),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            widget.terminal.name = _name.text;
            widget.terminal.type = _terminalType ?? api.TerminalType.port;
            if (_tenant != null) {
              widget.terminal.tenantId = _tenant!.id;
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

  @override
  void dispose() {
    _name.dispose();
    _tenantTypeAheadController.dispose();
    super.dispose();
  }
}
