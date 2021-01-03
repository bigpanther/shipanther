import 'package:flutter/material.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/terminal_extension.dart';

class TerminalAddEdit extends StatefulWidget {
  const TerminalAddEdit(
    this.loggedInUser, {
    required this.terminal,
    required this.terminalBloc,
    required this.isEdit,
  });

  final User loggedInUser;
  final Terminal terminal;
  final TerminalBloc terminalBloc;
  final bool isEdit;

  @override
  _TerminalAddEditState createState() => _TerminalAddEditState();
}

class _TerminalAddEditState extends State<TerminalAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _name;
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.terminal.name);
    _terminalType = widget.terminal.type;
  }

  late TerminalType _terminalType;
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
          child: ListView(children: [
            TextFormField(
              autofocus: !widget.isEdit,
              controller: _name,
              decoration: InputDecoration(
                  labelText: ShipantherLocalizations.of(context)!.terminalName),
              validator: (val) => val == null || val.trim().isEmpty
                  ? ShipantherLocalizations.of(context)!.paramEmpty(
                      ShipantherLocalizations.of(context)!.terminalName)
                  : null,
            ),
            smartSelect<TerminalType>(
              title: ShipantherLocalizations.of(context)!.terminalType,
              onChange: (state) => _terminalType = state.value,
              choiceItems: S2Choice.listFrom<TerminalType, TerminalType>(
                source: TerminalType.values,
                value: (index, item) => item,
                title: (index, item) => item.text,
              ),
              value: widget.terminal.type,
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit
            ? ShipantherLocalizations.of(context)!.edit
            : ShipantherLocalizations.of(context)!.create,
        child: const Icon(Icons.check),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            widget.terminal.name = _name.text;
            widget.terminal.type = _terminalType;
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
