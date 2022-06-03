import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:trober_sdk/trober_sdk.dart';

class TerminalAddEdit extends StatefulWidget {
  const TerminalAddEdit(
    this.loggedInUser, {
    required this.terminal,
    required this.terminalBloc,
    required this.isEdit,
    super.key,
  });

  final User loggedInUser;
  final Terminal terminal;
  final TerminalBloc terminalBloc;
  final bool isEdit;

  @override
  TerminalAddEditState createState() => TerminalAddEditState();
}

class TerminalAddEditState extends State<TerminalAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _name;
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.terminal.name);
    _terminalType = widget.terminal.type!;
  }

  late TerminalType _terminalType;
  final TextEditingController _tenantTypeAheadController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _tenantTypeAheadController.text = widget.terminal.tenantId!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? ShipantherLocalizations.of(context).editParam(
                  ShipantherLocalizations.of(context).terminalsTitle(1))
              : ShipantherLocalizations.of(context).addNewParam(
                  ShipantherLocalizations.of(context).terminalsTitle(1)),
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
            ShipantherTextFormField(
              controller: _name,
              labelText: ShipantherLocalizations.of(context).terminalName,
              validator: (val) => val == null || val.trim().isEmpty
                  ? ShipantherLocalizations.of(context).paramEmpty(
                      ShipantherLocalizations.of(context).terminalName)
                  : null,
            ),
            smartSelect<TerminalType>(
              context: context,
              title: ShipantherLocalizations.of(context).terminalType,
              onChange: (state) => _terminalType = state.value,
              choiceItems: S2Choice.listFrom<TerminalType, TerminalType>(
                source: TerminalType.values.toList(),
                value: (index, item) => item,
                title: (index, item) => item.name,
              ),
              value: widget.terminal.type!,
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit
            ? ShipantherLocalizations.of(context).edit
            : ShipantherLocalizations.of(context).create,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            var terminal = widget.terminal.rebuild((b) => b
              ..name = _name.text
              ..type = _terminalType);
            widget.terminal;
            if (widget.isEdit) {
              widget.terminalBloc.add(UpdateTerminal(terminal.id!, terminal));
            } else {
              widget.terminalBloc.add(CreateTerminal(terminal));
            }

            context.popRoute();
          }
        },
        child: const Icon(Icons.check),
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
