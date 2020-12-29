import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:shipanther/bloc/shipment/shipment_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:shipanther/extensions/user_extension.dart';
import 'package:shipanther/extensions/shipment_extension.dart';

class ShipmentAddEdit extends StatefulWidget {
  const ShipmentAddEdit(
    this.loggedInUser, {
    required this.shipment,
    required this.shipmentBloc,
    required this.isEdit,
  });
  final api.User loggedInUser;
  final api.Shipment shipment;
  final ShipmentBloc shipmentBloc;
  final bool isEdit;

  @override
  _ShipmentAddEditState createState() => _ShipmentAddEditState();
}

class _ShipmentAddEditState extends State<ShipmentAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  api.Terminal? _terminal;
  api.Carrier? _carrier;
  api.Order? _order;
  api.Tenant? _tenant;
  api.ShipmentSize? _shipmentSize;
  api.ShipmentType? _shipmentType;
  api.ShipmentStatus? _shipmentStatus;
  api.User? _driver;
  DateTime? _reservationTime;
  DateTime? _lfd;

  final TextEditingController _tenantTypeAheadController =
      TextEditingController();

  final TextEditingController _driverTypeAheadController =
      TextEditingController();
  final TextEditingController _terminalTypeAheadController =
      TextEditingController();
  final TextEditingController _orderTypeAheadController =
      TextEditingController();
  final TextEditingController _carrierTypeAheadController =
      TextEditingController();

  late TextEditingController _origin;
  late TextEditingController _destination;
  late TextEditingController _serialNumber;
  @override
  void initState() {
    super.initState();
    _serialNumber = TextEditingController(text: widget.shipment.serialNumber);
    _origin = TextEditingController(text: widget.shipment.origin);
    _destination = TextEditingController(text: widget.shipment.destination);
  }

  void _presentDateTimePickerReservationTime() {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onConfirm: (date) {
      setState(() {
        _reservationTime = date;
      });
    },
        currentTime:
            widget.isEdit ? widget.shipment.reservationTime : DateTime.now());
  }

  void _presentDateTimePickerlfd() {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onConfirm: (date) {
      setState(() {
        _lfd = date;
      });
    }, currentTime: widget.isEdit ? widget.shipment.lfd : DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _tenantTypeAheadController.text = widget.shipment.tenantId;
      _driverTypeAheadController.text = (widget.shipment.driver != null)
          ? widget.shipment.driver.name
          : widget.shipment.driverId;
      _terminalTypeAheadController.text = (widget.shipment.terminal != null)
          ? widget.shipment.terminal.name
          : widget.shipment.terminalId;
      _carrierTypeAheadController.text = (widget.shipment.carrier != null)
          ? widget.shipment.carrier.name
          : widget.shipment.carrierId;
      _orderTypeAheadController.text = (widget.shipment.order != null)
          ? widget.shipment.order.serialNumber
          : widget.shipment.orderId;
    }
    final formatter = ShipantherLocalizations.of(context)!.dateTimeFormatter;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? ShipantherLocalizations.of(context)!.editParam(
                  ShipantherLocalizations.of(context)!.shipmentsTitle(1))
              : ShipantherLocalizations.of(context)!.addNewParam(
                  ShipantherLocalizations.of(context)!.shipmentsTitle(1)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 100),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          onWillPop: () {
            widget.shipmentBloc.add(const GetShipments());
            return Future(() => true);
          },
          child: ListView(
            children: [
                  TextFormField(
                    autofocus: !widget.isEdit,
                    maxLength: 15,
                    controller: _serialNumber,
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(
                        labelText: ShipantherLocalizations.of(context)!
                            .shipmentSerialNumber),
                    validator: (val) => val == null || val.trim().isEmpty
                        ? ShipantherLocalizations.of(context)!.paramEmpty(
                            ShipantherLocalizations.of(context)!
                                .shipmentSerialNumber)
                        : null,
                  ),
                  TextFormField(
                    autofocus: !widget.isEdit,
                    controller: _origin,
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(
                        labelText: ShipantherLocalizations.of(context)!
                            .shipmentOrigin),
                  ),
                  TextFormField(
                    autofocus: !widget.isEdit,
                    controller: _destination,
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(
                        labelText: ShipantherLocalizations.of(context)!
                            .shipmentDestination),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 10, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(ShipantherLocalizations.of(context)!
                                .shipmentReservationTime),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              _reservationTime == null
                                  ? widget.shipment.reservationTime == null
                                      ? ShipantherLocalizations.of(context)!
                                          .noDateChosen
                                      : formatter.format(
                                          widget.shipment.reservationTime)
                                  : formatter.format(_reservationTime!),
                            ),
                            IconButton(
                              icon: const Icon(Icons.calendar_today),
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
                            Text(ShipantherLocalizations.of(context)!
                                .shipmentLFD),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              _lfd == null
                                  ? widget.shipment.lfd == null
                                      ? ShipantherLocalizations.of(context)!
                                          .noDateChosen
                                      : formatter.format(widget.shipment.lfd)
                                  : formatter.format(_lfd!),
                            ),
                            IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: _presentDateTimePickerlfd,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  smartSelect<api.ShipmentSize>(
                    title: ShipantherLocalizations.of(context)!.shipmentSize,
                    onChange: (state) => _shipmentSize = state.value,
                    choiceItems:
                        S2Choice.listFrom<api.ShipmentSize, api.ShipmentSize>(
                      source: api.ShipmentSize.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: widget.shipment.size ?? api.ShipmentSize.n20sT,
                  ),
                  smartSelect<api.ShipmentType>(
                    title: ShipantherLocalizations.of(context)!.shipmentType,
                    onChange: (state) => _shipmentType = state.value,
                    choiceItems:
                        S2Choice.listFrom<api.ShipmentType, api.ShipmentType>(
                      source: api.ShipmentType.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: widget.shipment.type ?? api.ShipmentType.incoming,
                  ),
                  smartSelect<api.ShipmentStatus>(
                    title: ShipantherLocalizations.of(context)!.shipmentStatus,
                    onChange: (state) => _shipmentStatus = state.value,
                    choiceItems: S2Choice.listFrom<api.ShipmentStatus,
                        api.ShipmentStatus>(
                      source: api.ShipmentStatus.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value:
                        widget.shipment.status ?? api.ShipmentStatus.unassigned,
                  ),
                ] +
                tenantSelector(
                    context, !widget.isEdit && widget.loggedInUser.isSuperAdmin,
                    (api.Tenant suggestion) {
                  _tenant = suggestion;
                }, _tenantTypeAheadController) +
                orderSelector(context, true, (api.Order suggestion) {
                  _order = suggestion;
                }, _orderTypeAheadController) +
                carrierSelector(context, true, (api.Carrier suggestion) {
                  _carrier = suggestion;
                }, _carrierTypeAheadController) +
                terminalSelector(context, true, (api.Terminal suggestion) {
                  _terminal = suggestion;
                }, _terminalTypeAheadController) +
                driverSelector(
                  context,
                  true,
                  (api.User suggestion) {
                    _driver = suggestion;
                  },
                  _driverTypeAheadController,
                ),
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
            widget.shipment.reservationTime =
                _reservationTime ?? widget.shipment.reservationTime;
            widget.shipment.lfd = _lfd ?? widget.shipment.lfd;
            widget.shipment.serialNumber = _serialNumber.text;
            widget.shipment.origin = _origin.text;
            widget.shipment.destination = _destination.text;
            widget.shipment.type = _shipmentType ?? api.ShipmentType.incoming;
            widget.shipment.status =
                _shipmentStatus ?? api.ShipmentStatus.unassigned;
            widget.shipment.size = _shipmentSize ?? api.ShipmentSize.n20sT;
            if (_tenant != null) {
              widget.shipment.tenantId = _tenant!.id;
            }
            if (_driver != null) {
              widget.shipment.driverId = _driver!.id;
            }
            if (_order != null) {
              widget.shipment.orderId = _order!.id;
            }
            if (_carrier != null) {
              widget.shipment.carrierId = _carrier!.id;
            }
            if (_terminal != null) {
              widget.shipment.terminalId = _terminal!.id;
            }
            widget.shipment.createdBy = widget.loggedInUser.id;

            if (widget.isEdit) {
              widget.shipmentBloc
                  .add(UpdateShipment(widget.shipment.id, widget.shipment));
            } else {
              widget.shipmentBloc.add(CreateShipment(widget.shipment));
            }

            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _serialNumber.dispose();
    _origin.dispose();
    _destination.dispose();
    _tenantTypeAheadController.dispose();
    _terminalTypeAheadController.dispose();
    _carrierTypeAheadController.dispose();
    _orderTypeAheadController.dispose();
    _driverTypeAheadController.dispose();
    super.dispose();
  }
}
