import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shipanther/bloc/carrier/carrier_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/date_time_picker.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:trober_sdk/trober_sdk.dart';

class CarrierAddEdit extends StatefulWidget {
  const CarrierAddEdit(
    this.loggedInUser, {
    required this.carrier,
    required this.carrierBloc,
    required this.isEdit,
    super.key,
  });
  final User loggedInUser;
  final Carrier carrier;
  final CarrierBloc carrierBloc;
  final bool isEdit;

  @override
  CarrierAddEditState createState() => CarrierAddEditState();
}

class CarrierAddEditState extends State<CarrierAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late FormGroup formGroup;

  @override
  void initState() {
    super.initState();
    formGroup = FormGroup({
      'name': FormControl<String>(
        value: widget.carrier.name,
        validators: [Validators.required],
      ),
      'eta': FormControl<DateTime>(
        value: widget.carrier.eta?.toLocal(),
      ),
    });
    _carrierType = widget.carrier.type;
  }

  late CarrierType _carrierType;

  @override
  Widget build(BuildContext context) {
    final l10n = ShipantherLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? l10n.editParam(l10n.carriersTitle(1))
              : l10n.addNewParam(l10n.carriersTitle(1)),
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
          child: ListView(children: [
            ShipantherTextFormField<String>(
                formControlName: 'name',
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLength: 20,
                labelText: l10n.carrierName,
                validationMessages: {
                  ValidationMessage.required: l10n.paramEmpty(l10n.carrierName)
                }),
            dateTimePicker(context, l10n.carriersETA, 'eta'),
            smartSelect<CarrierType>(
              context: context,
              title: l10n.carrierType,
              onChange: (state) => _carrierType = state.value,
              choiceItems: S2Choice.listFrom<CarrierType, CarrierType>(
                source: CarrierType.values.toList(),
                value: (index, item) => item,
                title: (index, item) => item.name,
              ),
              value: widget.carrier.type,
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit ? l10n.edit : l10n.create,
        onPressed: () {
          if (formGroup.valid) {
            var carrier = widget.carrier.rebuild((b) => b
              ..name = formGroup.control('name').value
              ..type = _carrierType
              ..eta = formGroup.control('eta').value?.toUtc());
            if (widget.isEdit) {
              widget.carrierBloc.add(UpdateCarrier(carrier.id, carrier));
            } else {
              widget.carrierBloc.add(CreateCarrier(carrier));
            }

            context.popRoute();
          } else {
            formGroup.markAllAsTouched();
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
