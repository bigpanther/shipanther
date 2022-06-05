import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
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
  late FormGroup formGroup;
  @override
  void initState() {
    super.initState();
    formGroup = FormGroup({
      'name': FormControl<String>(
        value: widget.customer.name,
        validators: [Validators.required],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    var l10n = ShipantherLocalizations.of(context);
    return ReactiveForm(
      formGroup: formGroup,
      key: formKey,
      onWillPop: () {
        return Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isEdit
                ? l10n.editParam(l10n.customersTitle(1))
                : l10n.addNewParam(l10n.customersTitle(1)),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: [
            ShipantherTextFormField<String>(
              formControlName: 'name',
              validationMessages: {
                ValidationMessage.required: l10n.paramEmpty(l10n.customerName),
              },
              labelText: l10n.customerName,
            ),
          ]),
        ),
        floatingActionButton:
            ReactiveFormConsumer(builder: (context, form, child) {
          return FloatingActionButton(
            tooltip: widget.isEdit ? l10n.edit : l10n.create,
            onPressed: form.valid
                ? () {
                    var customer = widget.customer
                        .rebuild((b) => b..name = form.control('name').value);
                    if (widget.isEdit) {
                      widget.customerBloc
                          .add(UpdateCustomer(customer.id, customer));
                    } else {
                      widget.customerBloc.add(CreateCustomer(customer));
                    }

                    context.popRoute();
                  }
                : null,
            child: const Icon(Icons.check),
          );
        }),
      ),
    );
  }
}
