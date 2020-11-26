import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/widgets/tenant_selector.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart';

class TerminalAddEdit extends StatefulWidget {
  final User user;
  final Terminal terminal;
  final TerminalBloc terminalBloc;
  final bool isEdit;

  TerminalAddEdit(
    this.user, {
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
  TerminalType _terminalType;
  Tenant _tenant;

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
                    SmartSelect<TerminalType>.single(
                      title: "Terminal type",
                      onChange: (state) => _terminalType = state.value,
                      choiceItems:
                          S2Choice.listFrom<TerminalType, TerminalType>(
                        source: TerminalType.values,
                        value: (index, item) => item,
                        title: (index, item) => item.toString(),
                      ),
                      modalType: S2ModalType.popupDialog,
                      modalHeader: false,
                      tileBuilder: (context, state) {
                        return S2Tile.fromState(
                          state,
                          trailing: const Icon(Icons.arrow_drop_down),
                          isTwoLine: true,
                        );
                      },
                      value: widget.terminal.type ?? TerminalType.port,
                    ),
                    Text(
                        widget.isEdit || widget.user.role != UserRole.superAdmin
                            ? ''
                            : 'Select a tenant'),
                  ] +
                  tenantSelector(context,
                      !widget.isEdit && widget.user.role == UserRole.superAdmin,
                      (Tenant suggestion) {
                    _tenant = suggestion;
                  })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit ? "Edit" : "Create",
        child: Icon(widget.isEdit ? Icons.check : Icons.add),
        onPressed: () async {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            widget.terminal.name = _terminalName;
            widget.terminal.type = _terminalType ?? TerminalType.port;
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
