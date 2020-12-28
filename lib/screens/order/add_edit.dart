import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:shipanther/extensions/user_extension.dart';
import 'package:shipanther/extensions/order_extension.dart';

class OrderAddEdit extends StatefulWidget {
  const OrderAddEdit(
    this.loggedInUser, {
    required this.order,
    required this.orderBloc,
    required this.isEdit,
  });
  final api.User loggedInUser;
  final api.Order order;
  final OrderBloc orderBloc;
  final bool isEdit;

  @override
  _OrderAddEditState createState() => _OrderAddEditState();
}

class _OrderAddEditState extends State<OrderAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _serialNumber = TextEditingController();
  api.OrderStatus? _orderStatus;
  api.Tenant? _tenant;
  api.Customer? _customer;
  final TextEditingController _tenantTypeAheadController =
      TextEditingController();
  final TextEditingController _customerTypeAheadController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _tenantTypeAheadController.text = widget.order.tenantId;
      _customerTypeAheadController.text = (widget.order.customer != null)
          ? widget.order.customer.name
          : widget.order.customerId;
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
            widget.orderBloc.add(const GetOrders(null));
            return Future(() => true);
          },
          child: ListView(
            children: [
                  TextFormField(
                    initialValue: widget.order.serialNumber,
                    autofocus: !widget.isEdit,
                    controller: _serialNumber,
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(
                        labelText:
                            ShipantherLocalizations.of(context).orderNumber),
                    maxLength: 15,
                    validator: (val) => val == null || val.trim().isEmpty
                        ? ShipantherLocalizations.of(context).paramEmpty(
                            ShipantherLocalizations.of(context).orderNumber)
                        : null,
                  ),
                  if (!widget.loggedInUser.isCustomer)
                    smartSelect<api.OrderStatus>(
                      title: ShipantherLocalizations.of(context).orderStatus,
                      onChange: (state) => _orderStatus = state.value,
                      choiceItems:
                          S2Choice.listFrom<api.OrderStatus, api.OrderStatus>(
                        source: api.OrderStatus.values,
                        value: (index, item) => item,
                        title: (index, item) => item.text,
                      ),
                      value: widget.order.status ?? api.OrderStatus.open,
                    )
                  else
                    Container(width: 0.0, height: 0.0),
                  // Hack to avoid runtime type mismatch.
                  Container(width: 0.0, height: 0.0),
                ] +
                tenantSelector(
                  context,
                  widget.isEdit && widget.loggedInUser.isSuperAdmin,
                  (api.Tenant suggestion) {
                    _tenant = suggestion;
                  },
                  _tenantTypeAheadController,
                ) +
                customerSelector(
                  context,
                  !widget.loggedInUser.isCustomer,
                  (api.Customer suggestion) {
                    _customer = suggestion;
                  },
                  _customerTypeAheadController,
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
          if (formKey.currentState!.validate()) {
            widget.order.serialNumber = _serialNumber.text;
            widget.order.status = _orderStatus ?? api.OrderStatus.open;
            if (widget.loggedInUser.isCustomer) {
              widget.order.customerId = widget.loggedInUser.customerId;
              _customer = null;
            }
            if (_customer != null) {
              widget.order.customerId = _customer!.id;
            }
            if (_tenant != null) {
              widget.order.tenantId = _tenant!.id;
            }
            widget.order.createdBy =
                (await context.read<UserRepository>().self()).id;
            if (widget.isEdit) {
              widget.orderBloc.add(UpdateOrder(widget.order.id, widget.order));
            } else {
              widget.orderBloc.add(CreateOrder(widget.order));
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
    _tenantTypeAheadController.dispose();
    _customerTypeAheadController.dispose();
    super.dispose();
  }
}
