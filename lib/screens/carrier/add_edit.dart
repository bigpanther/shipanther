import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/carrier/carrier_bloc.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/widgets/tenant_selector.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart';

class CarrierAddEdit extends StatefulWidget {
  final User loggedInUser;
  final Carrier carrier;
  final CarrierBloc carrierBloc;
  final bool isEdit;

  CarrierAddEdit(
    this.loggedInUser, {
    Key key,
    @required this.carrier,
    @required this.carrierBloc,
    @required this.isEdit,
  });

  @override
  _CarrierAddEditState createState() => _CarrierAddEditState();
}

class _CarrierAddEditState extends State<CarrierAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _carrierName;
  CarrierType _carrierType;
  Tenant _tenant;
  DateTime pickedDate;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    void _presentDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2019),
              lastDate: DateTime(2030))
          .then((value) {
        if (value == null) {
          return;
        }

        setState(() {
          pickedDate = value;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? "Edit carrier" : "Add new carrier",
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
                    initialValue: widget.carrier.name ?? '',
                    autofocus: widget.isEdit ? false : true,
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(hintText: 'Carrier Name'),
                    validator: (val) => val.trim().isEmpty
                        ? "Carrier name should not be empty"
                        : null,
                    onSaved: (value) => _carrierName = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Text(
                      'Pick a Date',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    onTap: _presentDatePicker,
                  ),
                  Text(
                    pickedDate == null
                        ? 'No Date Chosen'
                        : 'Date: ' + formatter.format(pickedDate),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SmartSelect<CarrierType>.single(
                    title: "Carrier type",
                    onChange: (state) => _carrierType = state.value,
                    choiceItems: S2Choice.listFrom<CarrierType, CarrierType>(
                      source: CarrierType.values,
                      value: (index, item) => item,
                      title: (index, item) => item.toString(),
                    ),
                    modalType: S2ModalType.popupDialog,
                    modalHeader: false,
                    tileBuilder: (context, state) {
                      return S2Tile.fromState(
                        state,
                        trailing: const Icon(Icons.arrow_drop_down),
                        isTwoLine: true,
                      );
                    },
                    value: widget.carrier.type ?? CarrierType.vessel,
                  ),
                  Text(widget.isEdit || widget.user.role != UserRole.superAdmin
                      ? ''
                      : 'Select a tenant'),
                ] +
                tenantSelector(context,
                    !widget.isEdit && widget.user.role == UserRole.superAdmin,
                    (Tenant suggestion) {
                  _tenant = suggestion;
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit ? "Edit" : "Create",
        child: Icon(widget.isEdit ? Icons.check : Icons.add),
        onPressed: () async {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            widget.carrier.name = _carrierName;
            widget.carrier.type = _carrierType;
            if (_tenant != null) {
              widget.carrier.tenantId = _tenant.id;
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
}
