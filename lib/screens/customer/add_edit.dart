import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/customer/customer_bloc.dart';
import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:trober_sdk/api.dart';

class CustomerAddEdit extends StatefulWidget {
  final User user;
  final Customer customer;
  final CustomerBloc customerBloc;
  final bool isEdit;

  CustomerAddEdit(
    this.user, {
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
                      //key: ArchSampleKeys.containerNameField,
                      autofocus: widget.isEdit ? false : true,
                      style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(hintText: 'Customer Name'
                          //ArchSampleLocalizations.of(context).containerNameHint,
                          ),
                      validator: (val) => val.trim().isEmpty
                          ? "Customer name should not be empty" //ArchSampleLocalizations.of(context).emptyTenantError
                          : null,
                      onSaved: (value) => _customerName = value,
                    ),
                    Text(''),
                  ] +
                  tenantSelector(context,
                      !widget.isEdit && widget.user.role == UserRole.superAdmin,
                      (Tenant suggestion) {
                    _tenant = suggestion;
                  })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // key: isEditing
        //     ? ArchSampleKeys.saveTenantFab
        //     : ArchSampleKeys.saveNewTenant,
        tooltip: widget.isEdit
            ? "Edit" //ArchSampleLocalizations.of(context).saveChanges
            : "Create", //ArchSampleLocalizations.of(context).addTenant,
        child: Icon(widget.isEdit ? Icons.check : Icons.add),
        onPressed: () async {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            widget.customer.name = _customerName;
            if (_tenant != null) {
              widget.customer.tenantId = _tenant.id;
            } else {
              widget.customer.tenantId = widget.user.tenantId;
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

List<StatefulWidget> tenantSelector(BuildContext context, bool shouldShow,
    void Function(Tenant) onSuggestionSelected) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<Tenant>(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(hintText: 'Select tenant'),
      ),
      suggestionsCallback: (pattern) async {
        var client = await context.read<ApiRepository>().apiClient();
        return (await client.tenantsGet())
            .where((element) => element.name.toLowerCase().startsWith(pattern));
      },
      itemBuilder: (context, Tenant tenant) {
        return ListTile(
          leading: Icon(Icons.business),
          title: Text(tenant.name),
          subtitle: Text(tenant.id),
        );
      },
      onSuggestionSelected: onSuggestionSelected,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please select a tenant';
      //   }
      //   return null;
      // },
    ),
  ];
}
