import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';

import 'package:shipanther/l10n/shipanther_localization.dart';
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
  api.CarrierType _carrierType;
  DateTime _reservationTime;
  DateTime _lfd;

  void _presentDateTimePickerReservationTime() {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onConfirm: (date) {
      setState(() {
        _reservationTime = date;
      });
      print('confirm $date');
    }, currentTime: DateTime.now());
  }

  void _presentDateTimePickerlfd() {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onConfirm: (date) {
      setState(() {
        _lfd = date;
      });
      print('confirm $date');
    }, currentTime: DateTime.now());
  }

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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 13, right: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Reservation time'),
                            ],
                          ),
                          Row(
                            children: [
                              Text(_reservationTime == null
                                  ? ShipantherLocalizations.of(context)
                                      .noDateChosen
                                  : DateFormat('dd-MM-yy - kk:mm')
                                      .format(_reservationTime)),
                              IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed:
                                    _presentDateTimePickerReservationTime,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 13, right: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('LFD'),
                            ],
                          ),
                          Row(
                            children: [
                              Text(_lfd == null
                                  ? ShipantherLocalizations.of(context)
                                      .noDateChosen
                                  : DateFormat('dd-MM-yy - kk:mm')
                                      .format(_lfd)),
                              IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: _presentDateTimePickerlfd,
                              )
                            ],
                          )
                        ],
                      ),
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
                    SmartSelect<api.CarrierType>.single(
                      title: "Carrier Type",
                      onChange: (state) => _carrierType = state.value,
                      choiceItems:
                          S2Choice.listFrom<api.CarrierType, api.CarrierType>(
                        source: api.CarrierType.values,
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
                      value: widget.container.type ?? api.CarrierType.road,
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
