import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:shipanther/bloc/carrier/carrier_bloc.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/user_extension.dart';
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
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.carrier.name);
  }

  CarrierType? _carrierType;
  Tenant? _tenant;
  DateTime? _eta;
  final TextEditingController _tenantTypeAheadController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formatter = ShipantherLocalizations.of(context)!.dateTimeFormatter;

    if (widget.isEdit) {
      _tenantTypeAheadController.text = widget.carrier.tenantId;
    }
    void _presentDateTimePicker() {
      DatePicker.showDateTimePicker(context, showTitleActions: true,
          onConfirm: (date) {
        setState(() {
          _eta = date;
        });
      }, currentTime: DateTime.now());
    }

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
          child: ListView(
            children: [
                  TextFormField(
                    autofocus: !widget.isEdit,
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(
                        hintText:
                            ShipantherLocalizations.of(context)!.carrierName),
                    validator: (val) => val == null || val.trim().isEmpty
                        ? ShipantherLocalizations.of(context)!.paramEmpty(
                            ShipantherLocalizations.of(context)!.carrierName)
                        : null,
                    controller: _name,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 10, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(ShipantherLocalizations.of(context)!
                                .carriersETA),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              _eta == null
                                  ? widget.carrier.eta == null
                                      ? ShipantherLocalizations.of(context)!
                                          .noDateChosen
                                      : formatter.format(widget.carrier.eta)
                                  : formatter.format(_eta!),
                            ),
                            IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: _presentDateTimePicker,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  smartSelect<CarrierType>(
                    title: ShipantherLocalizations.of(context)!.carrierType,
                    onChange: (state) => _carrierType = state.value,
                    choiceItems:
                        S2Choice.listFrom<CarrierType, CarrierType>(
                      source: CarrierType.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: widget.carrier.type ?? CarrierType.vessel,
                  ),
                  // Hack to avoid runtime type mismatch.
                  Container(width: 0.0, height: 0.0),
                ] +
                tenantSelector(
                    context, widget.isEdit && widget.loggedInUser.isSuperAdmin,
                    (Tenant suggestion) {
                  _tenant = suggestion;
                }, _tenantTypeAheadController),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit
            ? ShipantherLocalizations.of(context)!.edit
            : ShipantherLocalizations.of(context)!.create,
        child: Icon(widget.isEdit ? Icons.check : Icons.add),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            widget.carrier.name = _name.text;
            widget.carrier.type = _carrierType;
            if (_tenant != null) {
              widget.carrier.tenantId = _tenant!.id;
            }
            widget.carrier.createdBy =
                (await context.read<UserRepository>().self()).id;
            if (widget.isEdit) {
              widget.carrierBloc
                  .add(UpdateCarrier(widget.carrier.id, widget.carrier));
            } else {
              widget.carrierBloc.add(CreateCarrier(widget.carrier));
            }

            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _tenantTypeAheadController.dispose();
    _name.dispose();
    super.dispose();
  }
}
