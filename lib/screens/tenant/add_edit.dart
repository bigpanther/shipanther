import 'package:flutter/material.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:trober_sdk/trober_sdk.dart';

class TenantAddEdit extends StatefulWidget {
  const TenantAddEdit({
    required this.tenant,
    required this.tenantBloc,
    required this.isEdit,
    super.key,
  });

  final Tenant tenant;
  final TenantBloc tenantBloc;
  final bool isEdit;

  @override
  TenantAddEditState createState() => TenantAddEditState();
}

class TenantAddEditState extends State<TenantAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TenantType _tenantType;
  late TextEditingController _name;
  @override
  void initState() {
    super.initState();
    _tenantType = widget.tenant.type;
    _name = TextEditingController(text: widget.tenant.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? ShipantherLocalizations.of(context).editParam(
                  ShipantherLocalizations.of(context).tenantsTitle(1))
              : ShipantherLocalizations.of(context).addNewParam(
                  ShipantherLocalizations.of(context).tenantsTitle(1)),
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
          child: ListView(
            children: [
              ShipantherTextFormField(
                controller: _name,
                labelText: ShipantherLocalizations.of(context).tenantName,
                validator: (val) => val == null || val.trim().isEmpty
                    ? ShipantherLocalizations.of(context).paramEmpty(
                        ShipantherLocalizations.of(context).tenantName)
                    : null,
              ),
              smartSelect<TenantType>(
                context: context,
                title: ShipantherLocalizations.of(context).tenantType,
                onChange: (state) => _tenantType = state.value,
                choiceItems: S2Choice.listFrom<TenantType, TenantType>(
                  source: TenantType.values.toList(),
                  value: (index, item) => item,
                  title: (index, item) => item.name,
                ),
                value: widget.tenant.type,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit
            ? ShipantherLocalizations.of(context).edit
            : ShipantherLocalizations.of(context).create,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            var tenant = widget.tenant.rebuild((b) => b
              ..name = _name.text
              ..type = _tenantType);
            if (widget.isEdit) {
              widget.tenantBloc.add(
                UpdateTenant(tenant.id, tenant),
              );
            } else {
              widget.tenantBloc.add(
                CreateTenant(tenant),
              );
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
    _name.dispose();
    super.dispose();
  }
}
