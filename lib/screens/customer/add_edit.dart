import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/customer/customer_bloc.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/widgets/tenant_selector.dart';
import 'package:trober_sdk/api.dart';

class CustomerAddEdit extends StatefulWidget {
  final User loggedInUser;
  final Customer customer;
  final CustomerBloc customerBloc;
  final bool isEdit;

  CustomerAddEdit(
    this.loggedInUser, {
    Key key,
    @required this.customer,
    @required this.customerBloc,
    @required this.isEdit,
  });

  @override
  _CustomerAddEditState createState() => _CustomerAddEditState();
}

class _CustomerAddEditState extends State<CustomerAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _customerName;
  Tenant _tenant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? "Edit customer" : "Add new customer",
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
                      initialValue: widget.customer.name ?? '',
                      autofocus: widget.isEdit ? false : true,
                      style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(hintText: 'Customer Name'),
                      validator: (val) => val.trim().isEmpty
                          ? "Customer name should not be empty"
                          : null,
                      onSaved: (value) => _customerName = value,
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
                  })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit ? "Edit" : "Create",
        child: Icon(widget.isEdit ? Icons.check : Icons.add),
        onPressed: () async {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            widget.customer.name = _customerName;
            if (_tenant != null) {
              widget.customer.tenantId = _tenant.id;
            } else {
              widget.customer.tenantId = widget.loggedInUser.tenantId;
            }
            widget.customer.createdBy =
                (await context.read<UserRepository>().self()).id;
            if (widget.isEdit) {
              widget.customerBloc
                  .add(UpdateCustomer(widget.customer.id, widget.customer));
            } else {
              widget.customerBloc.add(CreateCustomer(widget.customer));
            }

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
