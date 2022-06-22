import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/extensions/user_extension.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/date_time_picker.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:shipanther/widgets/uuid.dart';
import 'package:trober_sdk/trober_sdk.dart';

class OrderAddEdit extends StatefulWidget {
  const OrderAddEdit(
    this.loggedInUser, {
    required this.order,
    required this.orderBloc,
    required this.isEdit,
    super.key,
  });
  final User loggedInUser;
  final Order order;
  final OrderBloc orderBloc;
  final bool isEdit;

  @override
  OrderAddEditState createState() => OrderAddEditState();
}

class OrderAddEditState extends State<OrderAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FormGroup formGroup;
  late FormArray shipmentsFormArray;
  late ShipmentType? shipmentType;
  late ShipmentSize? shipmentSize;
  late OrderStatus _orderStatus;
  @override
  void initState() {
    super.initState();
    shipmentsFormArray = FormArray<String>([
      FormControl<String>(
        validators: [Validators.required],
      ),
    ], validators: [
      Validators.required
    ]);
    formGroup = FormGroup({
      'serialNumber': FormControl<String>(
        value: widget.order.serialNumber,
        validators: [Validators.required],
      ),
      'customer': FormControl<Customer>(
        value: widget.order.customer,
        validators: [Validators.required],
      ),
      'carrier': FormControl<Carrier>(
        value: widget.order.carrier,
        validators: [Validators.required],
      ),
      'terminal': FormControl<Terminal>(
        value: widget.order.terminal,
        validators: [Validators.required],
      ),
      'soNumber': FormControl<String>(value: widget.order.soNumber),
      'shipline': FormControl<String>(value: widget.order.shipline),
      'pickupCharges': FormControl<int>(value: widget.order.pickupCharges),
      'pickupCost': FormControl<int>(value: widget.order.pickupCost),
      'dropoffCharges': FormControl<int>(value: widget.order.dropoffCharges),
      'dropoffCost': FormControl<int>(value: widget.order.dropoffCost),
      'rld': FormControl<String>(value: widget.order.rld),
      'docco': FormControl<DateTime>(value: widget.order.docco?.toLocal()),
      'lfd': FormControl<DateTime>(value: widget.order.lfd?.toLocal()),
      'type': FormControl<ShipmentType>(value: widget.order.type),
      'erd': FormControl<DateTime>(value: widget.order.erd),
      'containerStatus': FormControl<String>(
        value: widget.order.containerStatus,
      ),
      'eta': FormControl<DateTime>(
        value: widget.order.eta?.toLocal(),
      ),
      'shipments': shipmentsFormArray,
    });
    _orderStatus = widget.order.status;
    shipmentType = widget.order.type;
    shipmentSize = ShipmentSize.n40hC;
  }

  @override
  Widget build(BuildContext context) {
    var l10n = ShipantherLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? l10n.editParam(l10n.ordersTitle(1))
              : l10n.addNewParam(l10n.ordersTitle(1)),
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 48.0),
        child: ReactiveForm(
          formGroup: formGroup,
          key: formKey,
          onWillPop: () {
            widget.orderBloc.add(const GetOrders());
            return Future(() => true);
          },
          child: ListView(
              children: [
                    ShipantherTextFormField<String>(
                      formControlName: 'serialNumber',
                      labelText: l10n.orderNumber,
                      maxLength: 15,
                      validationMessages: {
                        ValidationMessage.required:
                            l10n.paramEmpty(l10n.orderNumber)
                      },
                    ),
                    smartSelect<ShipmentType>(
                      context: context,
                      title: l10n.shipmentType,
                      onChange: (state) => shipmentType = state.value,
                      choiceItems:
                          S2Choice.listFrom<ShipmentType, ShipmentType>(
                        source: ShipmentType.values.toList(),
                        value: (index, item) => item,
                        title: (index, item) => item.name,
                      ),
                      value: widget.order.type ?? ShipmentType.inbound,
                    ),
                    if (!widget.isEdit)
                      smartSelect<ShipmentSize>(
                        context: context,
                        title: l10n.shipmentSize,
                        onChange: (state) => shipmentSize = state.value,
                        choiceItems:
                            S2Choice.listFrom<ShipmentSize, ShipmentSize>(
                          source: ShipmentSize.values.toList(),
                          value: (index, item) => item,
                          title: (index, item) => item.name,
                        ),
                        value: ShipmentSize.n40hC,
                      )
                    else
                      const SizedBox(width: 0.0, height: 0.0),
                    if (!widget.loggedInUser.isCustomer)
                      smartSelect<OrderStatus>(
                        context: context,
                        title: l10n.orderStatus,
                        onChange: (state) => _orderStatus = state.value,
                        choiceItems:
                            S2Choice.listFrom<OrderStatus, OrderStatus>(
                          source: OrderStatus.values.toList(),
                          value: (index, item) => item,
                          title: (index, item) => item.name,
                        ),
                        value: _orderStatus,
                      )
                    else
                      const SizedBox(width: 0.0, height: 0.0),
                    // Hack to avoid runtime type mismatch.
                    const SizedBox(width: 0.0, height: 0.0),
                  ] +
                  customerSelector(
                      context, 'customer', widget.loggedInUser.isCustomer, {
                    ValidationMessage.required:
                        l10n.paramEmpty(l10n.customersTitle(1))
                  }) +
                  carrierSelector(context, 'carrier', false, {
                    ValidationMessage.required:
                        l10n.paramEmpty(l10n.carrierName)
                  }) +
                  terminalSelector(context, 'terminal', false, {
                    ValidationMessage.required:
                        l10n.paramEmpty(l10n.terminalName)
                  }) +
                  [
                    const ShipantherTextFormField<String>(
                      formControlName: 'shipline',
                      labelText: 'Shipline',
                      maxLength: 15,
                      validationMessages: {},
                    ),
                    const ShipantherTextFormField<String>(
                      formControlName: 'soNumber',
                      labelText: 'SO#',
                      maxLength: 15,
                      validationMessages: {},
                    ),
                    const ShipantherTextFormField<String>(
                      formControlName: 'containerStatus',
                      labelText: 'Container Status',
                      maxLength: 20,
                      validationMessages: {},
                    ),
                    const ShipantherTextFormField<int>(
                      formControlName: 'pickupCharges',
                      labelText: 'Pickup Charges',
                      maxLength: 15,
                      validationMessages: {},
                      keyboardType: TextInputType.number,
                    ),
                    const ShipantherTextFormField<int>(
                      formControlName: 'pickupCost',
                      labelText: 'Pickup Cost',
                      maxLength: 15,
                      keyboardType: TextInputType.number,
                      validationMessages: {},
                    ),
                    const ShipantherTextFormField<int>(
                      formControlName: 'dropoffCharges',
                      labelText: 'DropOff Charges',
                      maxLength: 15,
                      validationMessages: {},
                      keyboardType: TextInputType.number,
                    ),
                    const ShipantherTextFormField<int>(
                      formControlName: 'dropoffCost',
                      labelText: 'DropOff Cost',
                      maxLength: 15,
                      keyboardType: TextInputType.number,
                      validationMessages: {},
                    ),
                    const ShipantherTextFormField<String>(
                      formControlName: 'rld',
                      labelText: 'RLD',
                      maxLength: 15,
                      keyboardType: TextInputType.number,
                      validationMessages: {},
                    ),
                    dateTimePicker(context, l10n.carriersETA, 'eta'),
                    dateTimePicker(context, 'Doc C/O', 'docco'),
                    dateTimePicker(context, 'ERD', 'erd'),
                    dateTimePicker(context, 'LFD', 'lfd'),
                  ] +
                  [
                    if (!widget.isEdit)
                      ReactiveFormArray(
                        key: ObjectKey(shipmentsFormArray),
                        formArray: shipmentsFormArray,
                        builder: (BuildContext context,
                            FormArray<dynamic> formArray, Widget? child) {
                          final shipments =
                              formArray.controls.asMap().entries.map((control) {
                            var controlIndex = control.key;
                            var currentform =
                                control.value as FormControl<String>?;
                            return ShipantherTextFormField<String>(
                              key: ObjectKey(currentform),
                              formControl: currentform,
                              labelText: l10n.shipmentSerialNumber,
                              maxLength: 15,
                              suffixIconData: Icons.delete,
                              onSuffixButtonPressed: () {
                                remoteFromFormArray(controlIndex);
                              },
                              validationMessages: {
                                ValidationMessage.required:
                                    l10n.paramEmpty(l10n.shipmentSerialNumber)
                              },
                            );
                          });
                          return Wrap(
                            runSpacing: 20,
                            children: shipments.toList(),
                          );
                        },
                      )
                    else
                      const SizedBox(width: 0.0, height: 0.0),
                  ] +
                  [
                    if (!widget.isEdit)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: addToFormArray,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      )
                    else
                      const SizedBox(width: 0.0, height: 0.0),
                  ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit ? l10n.edit : l10n.create,
        onPressed: () {
          if (formGroup.valid) {
            var order = widget.order.rebuild((b) => b
              ..serialNumber = formGroup.control('serialNumber').value
              ..status = _orderStatus
              ..type = shipmentType ?? ShipmentType.inbound
              ..containerStatus = formGroup.control('containerStatus').value
              ..carrierId = formGroup.control('carrier').value.id
              ..terminalId = formGroup.control('terminal').value.id
              ..shipline = formGroup.control('shipline').value
              ..soNumber = formGroup.control('soNumber').value
              ..dropoffCost = formGroup.control('dropoffCost').value
              ..dropoffCharges = formGroup.control('dropoffCharges').value
              ..pickupCharges = formGroup.control('pickupCharges').value
              ..pickupCost = formGroup.control('pickupCost').value
              ..docco = formGroup.control('docco').value?.toUtc()
              ..erd = formGroup.control('erd').value?.toUtc()
              ..lfd = formGroup.control('lfd').value?.toUtc()
              ..eta = formGroup.control('eta').value?.toUtc());
            if (widget.loggedInUser.isCustomer) {
              order = order.rebuild(
                  (b) => b..customerId = widget.loggedInUser.customerId);
            } else {
              order = order.rebuild((b) =>
                  b..customerId = formGroup.control('customer').value.id);
            }

            if (widget.isEdit) {
              widget.orderBloc.add(UpdateOrder(order.id, order));
            } else {
              var shipmentArryValues = formGroup.control('shipments').value;

              order = order.rebuild((b) {
                var shipments = b.shipments;
                for (var name in shipmentArryValues) {
                  shipments.add(Shipment(((s) => s
                    ..serialNumber = name
                    ..type = order.type
                    ..status = ShipmentStatus.unassigned
                    ..createdAt = DateTime.now().toUtc()
                    ..updatedAt = DateTime.now().toUtc()
                    ..createdBy = widget.loggedInUser.id
                    ..id = uuid()
                    ..tenantId = widget.loggedInUser.tenantId
                    ..size = shipmentSize)));
                }
                return b..shipments = shipments.build().toBuilder();
              });
              widget.orderBloc.add(CreateOrder(order));
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

  void addToFormArray() async {
    shipmentsFormArray.add(
      FormControl<String>(
        validators: [Validators.required],
      ),
    );
    setState(() {});
  }

  void remoteFromFormArray(int controlIndex) async {
    shipmentsFormArray.removeAt(controlIndex);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
