import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shipanther/bloc/carrier/carrier_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/date_time_picker.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/trober_sdk.dart';

import 'package:shipanther/extensions/carrier_extension.dart';

class CarrierAddEdit extends StatefulWidget {
  const CarrierAddEdit(
    this.loggedInUser, {
    required this.carrier,
    required this.carrierBloc,
    required this.isEdit,
  });
  final User loggedInUser;
  final Carrier carrier;
  final CarrierBloc carrierBloc;
  final bool isEdit;

  @override
  _CarrierAddEditState createState() => _CarrierAddEditState();
}

class _CarrierAddEditState extends State<CarrierAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController _name;
  late TextEditingController _eta;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.carrier.name);
    _carrierType = widget.carrier.type;
    _eta = TextEditingController(
        text: widget.carrier.eta == null
            ? null
            : widget.carrier.eta!.toLocal().toString());
  }

  late CarrierType _carrierType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? ShipantherLocalizations.of(context)!.editParam(
                  ShipantherLocalizations.of(context)!.carriersTitle(1))
              : ShipantherLocalizations.of(context)!.addNewParam(
                  ShipantherLocalizations.of(context)!.carriersTitle(1)),
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
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              maxLength: 20,
              labelText: ShipantherLocalizations.of(context)!.carrierName,
              validator: (val) => val == null || val.trim().isEmpty
                  ? ShipantherLocalizations.of(context)!.paramEmpty(
                      ShipantherLocalizations.of(context)!.carrierName)
                  : null,
              controller: _name,
            ),
            dateTimePicker(context,
                ShipantherLocalizations.of(context)!.carriersETA, _eta),
            smartSelect<CarrierType>(
              context: context,
              title: ShipantherLocalizations.of(context)!.carrierType,
              onChange: (state) => _carrierType = state.value,
              choiceItems: S2Choice.listFrom<CarrierType, CarrierType>(
                source: CarrierType.values.toList(),
                value: (index, item) => item,
                title: (index, item) => item.text,
              ),
              value: widget.carrier.type,
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit
            ? ShipantherLocalizations.of(context)!.edit
            : ShipantherLocalizations.of(context)!.create,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            final cb = widget.carrier.toBuilder();

            cb.name = _name.text;
            cb.type = _carrierType;
            cb.eta = DateTime.tryParse(_eta.text);
            if (widget.isEdit) {
              widget.carrierBloc
                  .add(UpdateCarrier(widget.carrier.id!, cb.build()));
            } else {
              widget.carrierBloc.add(CreateCarrier(cb.build()));
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
    _eta.dispose();
    super.dispose();
  }
}
