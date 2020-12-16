import 'package:flutter/material.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/tenant_extension.dart';

class TenantAddEdit extends StatefulWidget {
  const TenantAddEdit({
    @required this.tenant,
    @required this.tenantBloc,
    @required this.isEdit,
  });

  final Tenant tenant;
  final TenantBloc tenantBloc;
  final bool isEdit;

  @override
  _TenantAddEditState createState() => _TenantAddEditState();
}

class _TenantAddEditState extends State<TenantAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _tenantName;
  TenantType _tenantType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? ShipantherLocalizations.of(context)
                  .editParam(ShipantherLocalizations.of(context).tenant)
              : ShipantherLocalizations.of(context)
                  .addNewParam(ShipantherLocalizations.of(context).tenant),
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
              TextFormField(
                initialValue: widget.tenant.name ?? '',
                autofocus: !widget.isEdit,
                style: Theme.of(context).textTheme.headline5,
                decoration: InputDecoration(
                    hintText: ShipantherLocalizations.of(context).tenantName),
                validator: (val) => val.trim().isEmpty
                    ? ShipantherLocalizations.of(context).paramEmpty(
                        ShipantherLocalizations.of(context).tenantName)
                    : null,
                onSaved: (value) => _tenantName = value,
              ),
              smartSelect<TenantType>(
                title: ShipantherLocalizations.of(context).tenantType,
                onChange: (state) => _tenantType = state.value,
                choiceItems: S2Choice.listFrom<TenantType, TenantType>(
                  source: TenantType.values,
                  value: (index, item) => item,
                  title: (index, item) => item.text,
                ),
                value: widget.tenant.type ?? TenantType.production,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit
            ? ShipantherLocalizations.of(context).edit
            : ShipantherLocalizations.of(context).create,
        child: Icon(widget.isEdit ? Icons.check : Icons.add),
        onPressed: () {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            widget.tenant.name = _tenantName;
            widget.tenant.type = _tenantType;
            if (widget.isEdit) {
              widget.tenantBloc.add(
                UpdateTenant(widget.tenant.id, widget.tenant),
              );
            } else {
              widget.tenantBloc.add(
                CreateTenant(widget.tenant),
              );
            }

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
