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
  final api.User loggedInUser;
  final api.Order order;
  final OrderBloc orderBloc;
  final bool isEdit;

  OrderAddEdit(
    this.loggedInUser, {
    Key key,
    @required this.order,
    @required this.orderBloc,
    @required this.isEdit,
  });

  @override
  _OrderAddEditState createState() => _OrderAddEditState();
}

class _OrderAddEditState extends State<OrderAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _orderSerialNumber;
  api.OrderStatus _orderStatus;
  api.Tenant _tenant;
  api.Customer _customer;
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
          widget.isEdit ? "Edit order" : "Add new order",
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
                    initialValue: widget.order.serialNumber ?? '',
                    autofocus: widget.isEdit ? false : true,
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(hintText: 'Order Number'),
                    maxLength: 15,
                    validator: (val) => val.trim().isEmpty
                        ? "Order number should not be empty"
                        : null,
                    onSaved: (value) => _orderSerialNumber = value,
                  ),
                  smartSelect<api.OrderStatus>(
                    title: "Order status",
                    onChange: (state) => _orderStatus = state.value,
                    choiceItems:
                        S2Choice.listFrom<api.OrderStatus, api.OrderStatus>(
                      source: api.OrderStatus.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: widget.order.status ?? api.OrderStatus.open,
                  ),
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
                  true,
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
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            widget.order.serialNumber = _orderSerialNumber;
            widget.order.status = _orderStatus ?? api.OrderStatus.open;
            if (_customer != null) {
              widget.order.customerId = _customer.id;
            }
            if (_tenant != null) {
              widget.order.tenantId = _tenant.id;
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

  void dispose() {
    _tenantTypeAheadController.dispose();
    _customerTypeAheadController.dispose();
    super.dispose();
  }
}
