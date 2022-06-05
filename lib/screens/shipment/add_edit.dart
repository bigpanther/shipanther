import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shipanther/bloc/shipment/shipment_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/date_time_picker.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:trober_sdk/trober_sdk.dart';

class ShipmentAddEdit extends StatefulWidget {
  const ShipmentAddEdit(
    this.loggedInUser, {
    required this.shipment,
    required this.shipmentBloc,
    required this.isEdit,
    this.imageURL,
    super.key,
  });
  final User loggedInUser;
  final Shipment shipment;
  final ShipmentBloc shipmentBloc;
  final bool isEdit;
  final String? imageURL;

  @override
  ShipmentAddEditState createState() => ShipmentAddEditState();
}

class ShipmentAddEditState extends State<ShipmentAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late ShipmentSize? _shipmentSize;
  late ShipmentType _shipmentType;
  late ShipmentStatus _shipmentStatus;

  late FormGroup formGroup;

  @override
  void initState() {
    super.initState();
    formGroup = FormGroup({
      'serialNumber': FormControl<String>(
        value: widget.shipment.serialNumber,
        validators: [Validators.required],
      ),
      'origin': FormControl<String>(
        value: widget.shipment.origin,
      ),
      'destination': FormControl<String>(
        value: widget.shipment.destination,
      ),
      'reservationTime': FormControl<DateTime>(
        value: widget.shipment.reservationTime?.toLocal(),
      ),
      'order': FormControl<Order>(
          //value: widget.shipment.order,
          //  validators: [Validators.required],
          ),
      'carrier': FormControl<Carrier>(
          //value: widget.shipment.order,
          //  validators: [Validators.required],
          ),
      'driver': FormControl<User>(
          //value: widget.shipment.order,
          // validators: [Validators.required],
          ),
    });
    _shipmentStatus = widget.shipment.status;
    _shipmentSize = widget.shipment.size;
    _shipmentType = widget.shipment.type;
  }

  Widget _imageContainer(String? imageURL) {
    if (imageURL == null) {
      return Container();
    }
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/shipanther_logo.png',
      image: imageURL,
    );
  }

  @override
  Widget build(BuildContext context) {
    var l10n = ShipantherLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? l10n.editParam(l10n.shipmentsTitle(1))
              : l10n.addNewParam(l10n.shipmentsTitle(1)),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 16),
          child: ReactiveForm(
            key: formKey,
            formGroup: formGroup,
            onWillPop: () {
              widget.shipmentBloc.add(const GetShipments());
              return Future(() => true);
            },
            child: ListView(
              children: [
                    ShipantherTextFormField<String>(
                        formControlName: 'serialNumber',
                        maxLength: 15,
                        labelText: l10n.shipmentSerialNumber,
                        validationMessages: {
                          ValidationMessage.required:
                              l10n.paramEmpty(l10n.shipmentSerialNumber)
                        }),
                    ShipantherTextFormField<String>(
                      formControlName: 'origin',
                      maxLength: 50,
                      labelText: l10n.shipmentOrigin,
                    ),
                    ShipantherTextFormField<String>(
                      formControlName: 'destination',
                      maxLength: 50,
                      labelText: l10n.shipmentDestination,
                    ),
                    dateTimePicker(context, l10n.shipmentReservationTime,
                        'reservationTime'),
                    smartSelect<ShipmentSize>(
                      context: context,
                      title: l10n.shipmentSize,
                      onChange: (state) => _shipmentSize = state.value,
                      choiceItems:
                          S2Choice.listFrom<ShipmentSize, ShipmentSize>(
                        source: ShipmentSize.values.toList(),
                        value: (index, item) => item,
                        title: (index, item) => item.name,
                      ),
                      value: widget.shipment.size ?? ShipmentSize.n20sT,
                    ),
                    smartSelect<ShipmentType>(
                      context: context,
                      title: l10n.shipmentType,
                      onChange: (state) => _shipmentType = state.value,
                      choiceItems:
                          S2Choice.listFrom<ShipmentType, ShipmentType>(
                        source: ShipmentType.values.toList(),
                        value: (index, item) => item,
                        title: (index, item) => item.name,
                      ),
                      value: widget.shipment.type,
                    ),
                    smartSelect<ShipmentStatus>(
                      context: context,
                      title: l10n.shipmentStatus,
                      onChange: (state) => _shipmentStatus = state.value,
                      choiceItems:
                          S2Choice.listFrom<ShipmentStatus, ShipmentStatus>(
                        source: ShipmentStatus.values.toList(),
                        value: (index, item) => item,
                        title: (index, item) => item.name,
                      ),
                      value: widget.shipment.status,
                    ),
                    const SizedBox(height: 8),
                  ] +
                  orderSelector(
                    context,
                    'order',
                    false,
                  ) +
                  carrierSelector(
                    context,
                    'carrier',
                    false,
                  ) +
                  driverSelector(
                    context,
                    'driver',
                    false,
                  ) +
                  [_imageContainer(widget.imageURL)],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit ? l10n.edit : l10n.create,
        onPressed: () {
          if (formGroup.valid) {
            var shipment = widget.shipment.rebuild((b) => b
              ..reservationTime =
                  formGroup.control('reservationTime').value?.toUtc()
              ..serialNumber = formGroup.control('serialNumber').value
              ..origin = formGroup.control('origin').value
              ..destination = formGroup.control('destination').value
              ..type = _shipmentType
              ..status = _shipmentStatus
              ..size = _shipmentSize);

            shipment = shipment.rebuild(
                (b) => b..tenantId = formGroup.control('tenant').value?.id);

            shipment = shipment.rebuild(
                (b) => b..driverId = formGroup.control('driver').value?.id);

            shipment = shipment.rebuild(
                (b) => b..orderId = formGroup.control('order').value?.id);

            shipment = shipment.rebuild(
                (b) => b..carrierId = formGroup.control('carrier').value?.id);

            shipment =
                shipment.rebuild((b) => b..createdBy = widget.loggedInUser.id);

            if (widget.isEdit) {
              widget.shipmentBloc.add(UpdateShipment(shipment.id, shipment));
            } else {
              widget.shipmentBloc.add(CreateShipment(shipment));
            }
            context.popRoute();
          } else {
            formGroup.markAllAsTouched();
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
