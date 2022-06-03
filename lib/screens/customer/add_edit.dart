import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/bloc/customer/customer_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'package:trober_sdk/trober_sdk.dart';

class CustomerAddEdit extends StatefulWidget {
  const CustomerAddEdit(
    this.loggedInUser, {
    required this.customer,
    required this.customerBloc,
    required this.isEdit,
    super.key,
  });
  final User loggedInUser;
  final Customer customer;
  final CustomerBloc customerBloc;
  final bool isEdit;

  @override
  CustomerAddEditState createState() => CustomerAddEditState();
}

class CustomerAddEditState extends State<CustomerAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _name;
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.customer.name);
  }

  final TextEditingController _tenantTypeAheadController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _tenantTypeAheadController.text = widget.customer.tenantId;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? ShipantherLocalizations.of(context).editParam(
                  ShipantherLocalizations.of(context).customersTitle(1))
              : ShipantherLocalizations.of(context).addNewParam(
                  ShipantherLocalizations.of(context).customersTitle(1)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(children: [
            ShipantherTextFormField(
              labelText: ShipantherLocalizations.of(context).customerName,
              validator: (val) => val == null || val.trim().isEmpty
                  ? ShipantherLocalizations.of(context).paramEmpty(
                      ShipantherLocalizations.of(context).customerName)
                  : null,
              controller: _name,
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit
            ? ShipantherLocalizations.of(context).edit
            : ShipantherLocalizations.of(context).create,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            var customer = widget.customer.rebuild((b) => b..name = _name.text);
            if (widget.isEdit) {
              widget.customerBloc.add(UpdateCustomer(customer.id, customer));
            } else {
              widget.customerBloc.add(CreateCustomer(customer));
            }

            context.popRoute();
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _tenantTypeAheadController.dispose();
    super.dispose();
  }
}
