import 'package:flutter/material.dart';
import 'package:shipanther/bloc/shipment/shipment_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/date_time_picker.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/shipment_extension.dart';

class ShipmentAddEdit extends StatefulWidget {
  const ShipmentAddEdit(
    this.loggedInUser, {
    required this.shipment,
    required this.shipmentBloc,
    required this.isEdit,
  });
  final User loggedInUser;
  final Shipment shipment;
  final ShipmentBloc shipmentBloc;
  final bool isEdit;

  @override
  _ShipmentAddEditState createState() => _ShipmentAddEditState();
}

class _ShipmentAddEditState extends State<ShipmentAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Terminal? _terminal;
  Carrier? _carrier;
  Order? _order;
  Tenant? _tenant;
  late ShipmentSize _shipmentSize;
  late ShipmentType _shipmentType;
  late ShipmentStatus _shipmentStatus;
  User? _driver;
  late TextEditingController _reservationTimeController;
  late TextEditingController _lfdController;

  late TextEditingController _tenantTypeAheadController;

  late TextEditingController _driverTypeAheadController;
  late TextEditingController _terminalTypeAheadController;
  late TextEditingController _orderTypeAheadController;
  late TextEditingController _carrierTypeAheadController;

  late TextEditingController _originController;
  late TextEditingController _destinationController;
  late TextEditingController _serialNumberController;
  @override
  void initState() {
    super.initState();
    _serialNumberController =
        TextEditingController(text: widget.shipment.serialNumber);
    _originController = TextEditingController(text: widget.shipment.origin);
    _destinationController =
        TextEditingController(text: widget.shipment.destination);
    _shipmentStatus = widget.shipment.status;
    _shipmentSize = widget.shipment.size;
    _shipmentType = widget.shipment.type;
    _tenantTypeAheadController =
        TextEditingController(text: widget.shipment.tenantId);
    _driverTypeAheadController = TextEditingController(
        text: (widget.shipment.driver != null)
            ? widget.shipment.driver.name
            : widget.shipment.driverId);
    _terminalTypeAheadController = TextEditingController(
        text: (widget.shipment.terminal != null)
            ? widget.shipment.terminal.name
            : widget.shipment.terminalId);
    _carrierTypeAheadController = TextEditingController(
        text: (widget.shipment.carrier != null)
            ? widget.shipment.carrier.name
            : widget.shipment.carrierId);
    _orderTypeAheadController = TextEditingController(
        text: (widget.shipment.order != null)
            ? widget.shipment.order.serialNumber
            : widget.shipment.orderId);
    _reservationTimeController = TextEditingController(
        text: (widget.shipment.reservationTime == null)
            ? null
            : widget.shipment.reservationTime.toString());
    _lfdController = TextEditingController(
        text: (widget.shipment.lfd == null)
            ? null
            : widget.shipment.lfd.toString());
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: _serialNumberController,
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
                    controller: _originController,
                    maxLength: 50,
                    decoration: InputDecoration(
                        labelText: ShipantherLocalizations.of(context)!
                            .shipmentOrigin),
                  ),
                  TextFormField(
                    autofocus: !widget.isEdit,
                    controller: _destinationController,
                    maxLength: 50,
                    decoration: InputDecoration(
                        labelText: ShipantherLocalizations.of(context)!
                            .shipmentDestination),
                  ),
                  TextFormField(
                    autofocus: !widget.isEdit,
                    controller: _destinationController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: ShipantherLocalizations.of(context)!
                            .shipmentReservationTime),
                  ),
                  dateTimePicker(
                      context,
                      ShipantherLocalizations.of(context)!
                          .shipmentReservationTime,
                      _reservationTimeController),
                  dateTimePicker(
                      context,
                      ShipantherLocalizations.of(context)!.shipmentLFD,
                      _lfdController),
                  smartSelect<ShipmentSize>(
                    title: ShipantherLocalizations.of(context)!.shipmentSize,
                    onChange: (state) => _shipmentSize = state.value,
                    choiceItems: S2Choice.listFrom<ShipmentSize, ShipmentSize>(
                      source: ShipmentSize.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: widget.shipment.size,
                  ),
                  smartSelect<ShipmentType>(
                    title: ShipantherLocalizations.of(context)!.shipmentType,
                    onChange: (state) => _shipmentType = state.value,
                    choiceItems: S2Choice.listFrom<ShipmentType, ShipmentType>(
                      source: ShipmentType.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: widget.shipment.type,
                  ),
                  smartSelect<ShipmentStatus>(
                    title: ShipantherLocalizations.of(context)!.shipmentStatus,
                    onChange: (state) => _shipmentStatus = state.value,
                    choiceItems:
                        S2Choice.listFrom<ShipmentStatus, ShipmentStatus>(
                      source: ShipmentStatus.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: widget.shipment.status,
                  ),
                  const SizedBox(height: 8),
                ] +
                orderSelector(context, true, (Order suggestion) {
                  _order = suggestion;
                }, _orderTypeAheadController) +
                carrierSelector(context, true, (Carrier suggestion) {
                  _carrier = suggestion;
                }, _carrierTypeAheadController) +
                terminalSelector(context, true, (Terminal suggestion) {
                  _terminal = suggestion;
                }, _terminalTypeAheadController) +
                driverSelector(
                  context,
                  true,
                  (User suggestion) {
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
        onPressed: () {
          if (formKey.currentState!.validate()) {
            widget.shipment.reservationTime =
                DateTime.tryParse(_reservationTimeController.text);
            widget.shipment.lfd = DateTime.tryParse(_lfdController.text);
            widget.shipment.serialNumber = _serialNumberController.text;
            widget.shipment.origin = _originController.text;
            widget.shipment.destination = _destinationController.text;
            widget.shipment.type = _shipmentType;
            widget.shipment.status = _shipmentStatus;
            widget.shipment.size = _shipmentSize;
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
    _serialNumberController.dispose();
    _originController.dispose();
    _destinationController.dispose();
    _tenantTypeAheadController.dispose();
    _terminalTypeAheadController.dispose();
    _carrierTypeAheadController.dispose();
    _orderTypeAheadController.dispose();
    _driverTypeAheadController.dispose();
    _reservationTimeController.dispose();
    _lfdController.dispose();
    super.dispose();
  }
}
