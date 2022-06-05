import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
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
  late FormGroup formGroup;

  @override
  void initState() {
    super.initState();
    formGroup = FormGroup({
      'name': FormControl<String>(
        value: widget.tenant.name,
        validators: [Validators.required],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    var l10n = ShipantherLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? l10n.editParam(l10n.tenantsTitle(1))
              : l10n.addNewParam(l10n.tenantsTitle(1)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          key: formKey,
          formGroup: formGroup,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(
            children: [
              ShipantherTextFormField<String>(
                  formControlName: 'name',
                  labelText: l10n.tenantName,
                  validationMessages: {
                    ValidationMessage.required: l10n.paramEmpty(l10n.tenantName)
                  }),
              smartSelect<TenantType>(
                context: context,
                title: l10n.tenantType,
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
        tooltip: widget.isEdit ? l10n.edit : l10n.create,
        onPressed: () {
          if (formGroup.valid) {
            var tenant = widget.tenant.rebuild((b) => b
              ..name = formGroup.control('name').value
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

            context.popRoute();
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
