import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/widgets/tenant_selector.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart';

class OrderAddEdit extends StatefulWidget {
  final User loggedInUser;
  final Order order;
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
  OrderStatus _orderStatus;
  Tenant _tenant;
  Customer _customer;

  @override
  Widget build(BuildContext context) {
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
                    validator: (val) => val.trim().isEmpty
                        ? "Order number should not be empty"
                        : null,
                    onSaved: (value) => _orderSerialNumber = value,
                  ),
                  SmartSelect<OrderStatus>.single(
                    title: "Order status",
                    onChange: (state) => _orderStatus = state.value,
                    choiceItems: S2Choice.listFrom<OrderStatus, OrderStatus>(
                      source: OrderStatus.values,
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
                    value: widget.order.status ?? OrderStatus.open,
                  ),
                  Text(widget.isEdit ||
                          widget.loggedInUser.role != UserRole.superAdmin
                      ? ''
                      : 'Select a tenant'),
                ] +
                tenantSelector(
                    context,
                    !widget.isEdit &&
                        widget.loggedInUser.role == UserRole.superAdmin,
                    (Tenant suggestion) {
                  _tenant = suggestion;
                }) +
                [
                  Text(widget.isEdit ? '' : 'Select a customer'),
                ] +
                customerSelector(context, true, (Customer suggestion) {
                  _customer = suggestion;
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit ? "Edit" : "Create",
        child: Icon(widget.isEdit ? Icons.check : Icons.add),
        onPressed: () async {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            widget.order.serialNumber = _orderSerialNumber;
            widget.order.status = _orderStatus ?? OrderStatus.open;
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
}
