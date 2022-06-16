import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/extensions/user_extension.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
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
  @override
  void initState() {
    super.initState();
    shipmentsFormArray = FormArray([
      FormGroup(
        {
          'shipment': FormControl<String>(
            // value: widget.order.serialNumber,
            validators: [Validators.required],
          ),
        },
      ),
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
      'shipments': shipmentsFormArray,
    });
    _orderStatus = widget.order.status;
  }

  late OrderStatus _orderStatus;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                        value: widget.order.status,
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
                  [
                    ReactiveFormArray(
                      formArrayName: 'shipments',
                      builder: (BuildContext context,
                          FormArray<dynamic> formArray, Widget? child) {
                        final shipments = shipmentsFormArray.controls
                            .asMap()
                            .entries
                            .map((control) {
                          var controlIndex = control.key;
                          var currentform = control.value as FormGroup;
                          return ReactiveForm(
                            formGroup: currentform,
                            child: Column(
                              children: <Widget>[
                                ShipantherTextFormField<String>(
                                  formControlName: 'shipment',
                                  labelText: l10n.orderNumber,
                                  maxLength: 15,
                                  suffixIconData: Icons.delete,
                                  onSuffixButtonPressed: () {
                                    remoteFromFormArray(controlIndex);
                                  },
                                  validationMessages: {
                                    ValidationMessage.required: l10n
                                        .paramEmpty(l10n.shipmentSerialNumber)
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                        return Wrap(
                          runSpacing: 20,
                          children: shipments.toList(),
                        );
                      },
                    ),
                  ] +
                  [
                    IconButton(
                      onPressed: addToFormArray,
                      icon: const Icon(Icons.add),
                    ),
                  ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit ? l10n.edit : l10n.create,
        onPressed: () {
          if (formGroup.valid) {
            var order = widget.order.rebuild((b) => b
              ..serialNumber = formGroup.control('serialNumber').value
              ..status = _orderStatus);
            if (widget.loggedInUser.isCustomer) {
              order = order.rebuild(
                  (b) => b..customerId = widget.loggedInUser.customerId);
            } else {
              order = order.rebuild((b) =>
                  b..customerId = formGroup.control('customer').value.id);
            }
            //print(formGroup.control('shipments').value);
            if (widget.isEdit) {
              widget.orderBloc.add(UpdateOrder(order.id, order));
            } else {
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
      FormGroup(
        {
          'shipment': FormControl<String>(
            // value: widget.order.serialNumber,
            validators: [Validators.required],
          ),
        },
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
