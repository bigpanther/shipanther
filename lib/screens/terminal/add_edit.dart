import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
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
  late FormGroup formGroup;
  @override
  void initState() {
    super.initState();
    formGroup = FormGroup({
      'name': FormControl<String>(
        value: widget.terminal.name,
        validators: [Validators.required],
      ),
    });
    _terminalType = widget.terminal.type!;
  }

  late TerminalType _terminalType;

  @override
  Widget build(BuildContext context) {
    var l10n = ShipantherLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? l10n.editParam(l10n.terminalsTitle(1))
              : l10n.addNewParam(l10n.terminalsTitle(1)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          key: formKey,
          formGroup: formGroup,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(children: [
            ShipantherTextFormField<String>(
                formControlName: 'name',
                labelText: l10n.terminalName,
                validationMessages: {
                  ValidationMessage.required: l10n.paramEmpty(l10n.terminalName)
                }),
            smartSelect<TerminalType>(
              context: context,
              title: l10n.terminalType,
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
        tooltip: widget.isEdit ? l10n.edit : l10n.create,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            var terminal = widget.terminal.rebuild((b) => b
              ..name = formGroup.control('name').value
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
}
