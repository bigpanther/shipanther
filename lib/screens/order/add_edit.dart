import 'package:flutter/material.dart';
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

  late TextEditingController _serialNumber;
  @override
  void initState() {
    super.initState();
    _serialNumber = TextEditingController(text: widget.order.serialNumber);
    _orderStatus = widget.order.status;
  }

  late OrderStatus _orderStatus;
  Customer? _customer;
  final TextEditingController _tenantTypeAheadController =
      TextEditingController();
  final TextEditingController _customerTypeAheadController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _tenantTypeAheadController.text = widget.order.tenantId;
      _customerTypeAheadController.text = (widget.order.customer != null)
          ? widget.order.customer!.name
          : widget.order.customerId ?? '';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? ShipantherLocalizations.of(context)
                  .editParam(ShipantherLocalizations.of(context).ordersTitle(1))
              : ShipantherLocalizations.of(context).addNewParam(
                  ShipantherLocalizations.of(context).ordersTitle(1)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          onWillPop: () {
            widget.orderBloc.add(const GetOrders());
            return Future(() => true);
          },
          child: ListView(
            children: [
                  ShipantherTextFormField(
                    controller: _serialNumber,
                    labelText: ShipantherLocalizations.of(context).orderNumber,
                    maxLength: 15,
                    validator: (val) => val == null || val.trim().isEmpty
                        ? ShipantherLocalizations.of(context).paramEmpty(
                            ShipantherLocalizations.of(context).orderNumber)
                        : null,
                  ),
                  if (!widget.loggedInUser.isCustomer)
                    smartSelect<OrderStatus>(
                      context: context,
                      title: ShipantherLocalizations.of(context).orderStatus,
                      onChange: (state) => _orderStatus = state.value,
                      choiceItems: S2Choice.listFrom<OrderStatus, OrderStatus>(
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
                  context,
                  !widget.loggedInUser.isCustomer,
                  (Customer suggestion) {
                    _customer = suggestion;
                  },
                  (val) => (val == null || val.trim().isEmpty)
                      ? ShipantherLocalizations.of(context).paramEmpty(
                          ShipantherLocalizations.of(context).customersTitle(1))
                      : null,
                  _customerTypeAheadController,
                ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit
            ? ShipantherLocalizations.of(context).edit
            : ShipantherLocalizations.of(context).create,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            var order = widget.order.rebuild((b) => b
              ..serialNumber = _serialNumber.text
              ..status = _orderStatus);
            if (widget.loggedInUser.isCustomer) {
              order = order.rebuild(
                  (b) => b..customerId = widget.loggedInUser.customerId);
              _customer = null;
            }
            if (_customer != null) {
              order = order.rebuild((b) => b..customerId = _customer!.id);
            }
            if (widget.isEdit) {
              widget.orderBloc.add(UpdateOrder(order.id, order));
            } else {
              widget.orderBloc.add(CreateOrder(order));
            }
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  @override
  void dispose() {
    _serialNumber.dispose();
    _tenantTypeAheadController.dispose();
    _customerTypeAheadController.dispose();
    super.dispose();
  }
}
