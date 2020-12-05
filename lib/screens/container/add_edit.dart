import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:shipanther/extensions/user_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/extensions/container_extension.dart';

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
  String _serialNumber;
  String _origin;
  String _destination;
  api.Terminal _terminal;
  api.Carrier _carrier;
  api.Order _order;
  api.Tenant _tenant;
  api.ContainerSize _containerSize;
  api.ContainerType _containerType;
  api.ContainerStatus _containerStatus;
  api.User _driver;
  DateTime _reservationTime;
  DateTime _lfd;

  void _presentDateTimePickerReservationTime() {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onConfirm: (date) {
      setState(() {
        _reservationTime = date;
      });
    }, currentTime: DateTime.now());
  }

  void _presentDateTimePickerlfd() {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onConfirm: (date) {
      setState(() {
        _lfd = date;
      });
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
                    onSaved: (value) => _serialNumber = value,
                  ),
                  TextFormField(
                    initialValue: widget.container.origin ?? '',
                    autofocus: widget.isEdit ? false : true,
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(hintText: 'Origin'),
                    onSaved: (value) => _origin = value,
                  ),
                  TextFormField(
                    initialValue: widget.container.destination ?? '',
                    autofocus: widget.isEdit ? false : true,
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(hintText: 'Destination'),
                    onSaved: (value) => _destination = value,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 10, top: 5),
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
                              onPressed: _presentDateTimePickerReservationTime,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 10, top: 5),
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
                                : DateFormat('dd-MM-yy - kk:mm').format(_lfd)),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: _presentDateTimePickerlfd,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  smartSelect<api.ContainerSize>(
                    title: "Container size",
                    onChange: (state) => _containerSize = state.value,
                    choiceItems:
                        S2Choice.listFrom<api.ContainerSize, api.ContainerSize>(
                      source: api.ContainerSize.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: widget.container.size ?? api.ContainerSize.n20sT,
                  ),
                  smartSelect<api.ContainerType>(
                    title: "Container type",
                    onChange: (state) => _containerType = state.value,
                    choiceItems:
                        S2Choice.listFrom<api.ContainerType, api.ContainerType>(
                      source: api.ContainerType.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: widget.container.type ?? api.ContainerType.incoming,
                  ),
                  smartSelect<api.ContainerStatus>(
                    title: "Container Status",
                    onChange: (state) => _containerStatus = state.value,
                    choiceItems: S2Choice.listFrom<api.ContainerStatus,
                        api.ContainerStatus>(
                      source: api.ContainerStatus.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: widget.container.status ??
                        api.ContainerStatus.unassigned,
                  ),
                ] +
                tenantSelector(
                  context,
                  !widget.isEdit && widget.loggedInUser.isSuperAdmin,
                  (api.Tenant suggestion) {
                    _tenant = suggestion;
                  },
                ) +
                orderSelector(context, true, (api.Order suggestion) {
                  _order = suggestion;
                }) +
                terminalSelector(context, true, (api.Terminal suggestion) {
                  _terminal = suggestion;
                }) +
                driverSelector(
                  context,
                  true,
                  (api.User suggestion) {
                    _driver = suggestion;
                  },
                ),
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
            widget.container.serialNumber = _serialNumber;
            widget.container.origin = _origin;
            widget.container.destination = _destination;
            widget.container.type =
                _containerType ?? api.ContainerType.incoming;
            widget.container.status =
                _containerStatus ?? api.ContainerStatus.unassigned;
            widget.container.size = _containerSize;
            if (_tenant != null) {
              widget.container.tenantId = _tenant.id;
            }
            var self = await context.read<UserRepository>().self();
            if (self.isDriver) {
              widget.container.driverId = self.id;
            }
            if (_driver != null) {
              widget.container.driverId = _driver.id;
            }
            if (_order != null) {
              widget.container.orderId = _order.id;
            }
            if (_carrier != null) {
              widget.container.carrierId = _carrier.id;
            }
            if (_terminal != null) {
              widget.container.terminalId = _terminal.id;
            }
            widget.container.createdBy = self.id;
            if (widget.isEdit) {
              widget.containerBloc
                  .add(UpdateContainer(widget.container.id, widget.container));
            } else {
              widget.containerBloc.add(CreateContainer(widget.container));
            }

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
