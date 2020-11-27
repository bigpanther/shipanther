import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/widgets/tenant_selector.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart' as api;

class ContainerAddEdit extends StatefulWidget {
  final api.User loggedInUser;
  final api.Container container;
  final ContainerBloc containerBloc;
  final bool isEdit;

  ContainerAddEdit(
    this.loggedInUser, {
    Key key,
    @required this.container,
    @required this.containerBloc,
    @required this.isEdit,
  });

  @override
  _ContainerAddEditState createState() => _ContainerAddEditState();
}

class _ContainerAddEditState extends State<ContainerAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _terminalName;
  api.Tenant _tenant;
  api.ContainerSize _containerSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? "Edit container" : "Add new container",
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
                      initialValue: widget.container.serialNumber ?? '',
                      autofocus: widget.isEdit ? false : true,
                      style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(hintText: 'Serial number'),
                      validator: (val) => val.trim().isEmpty
                          ? "Serial number should not be empty"
                          : null,
                      onSaved: (value) => _terminalName = value,
                    ),
                    SmartSelect<api.ContainerSize>.single(
                      title: "Container size",
                      onChange: (state) => _containerSize = state.value,
                      choiceItems: S2Choice.listFrom<api.ContainerSize,
                          api.ContainerSize>(
                        source: api.ContainerSize.values,
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
                      value: widget.container.size ?? api.ContainerSize.n20sT,
                    ),
                    Text(widget.isEdit ||
                            widget.loggedInUser.role != api.UserRole.superAdmin
                        ? ''
                        : 'Select a tenant'),
                  ] +
                  tenantSelector(
                      context,
                      !widget.isEdit &&
                          widget.loggedInUser.role == api.UserRole.superAdmin,
                      (api.Tenant suggestion) {
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
            // form.save();
            // widget.terminal.name = _terminalName;
            // widget.terminal.type = _terminalType ?? TerminalType.port;
            // if (_tenant != null) {
            //   widget.terminal.tenantId = _tenant.id;
            // }
            // widget.terminal.createdBy =
            //     (await context.read<UserRepository>().self()).id;
            // if (widget.isEdit) {
            //   widget.terminalBloc
            //       .add(UpdateTerminal(widget.terminal.id, widget.terminal));
            // } else {
            //   widget.terminalBloc.add(CreateTerminal(widget.terminal));
            // }

            // Navigator.pop(context);
          }
        },
      ),
    );
  }
}
