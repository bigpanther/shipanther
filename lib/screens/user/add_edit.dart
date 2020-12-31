import 'package:flutter/material.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/user_extension.dart';

class UserAddEdit extends StatefulWidget {
  const UserAddEdit(
    this.loggedInUser, {
    required this.user,
    required this.userBloc,
    required this.isEdit,
  });
  final User loggedInUser;
  final User user;
  final UserBloc userBloc;
  final bool isEdit;

  @override
  _UserAddEditState createState() => _UserAddEditState();
}

class _UserAddEditState extends State<UserAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController _name;
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.user.name);
  }

  UserRole? _userRole;
  Tenant? _tenant;
  final TextEditingController _tenantTypeAheadController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _tenantTypeAheadController.text = widget.user.tenantId;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? ShipantherLocalizations.of(context)!
                  .editParam(ShipantherLocalizations.of(context)!.usersTitle(1))
              : ShipantherLocalizations.of(context)!.addNewParam(
                  ShipantherLocalizations.of(context)!.usersTitle(1)),
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
                    controller: _name,
                    style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(
                        labelText:
                            ShipantherLocalizations.of(context)!.userName),
                    validator: (val) => val == null || val.trim().isEmpty
                        ? ShipantherLocalizations.of(context)!.paramEmpty(
                            ShipantherLocalizations.of(context)!.userName)
                        : null,
                  ),
                  smartSelect<UserRole>(
                    title: ShipantherLocalizations.of(context)!.userType,
                    onChange: (state) => _userRole = state.value,
                    choiceItems: S2Choice.listFrom<UserRole, UserRole>(
                      source: UserRole.values,
                      value: (index, item) => item,
                      title: (index, item) => item.text,
                    ),
                    value: _userRole ?? widget.user.role,
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
        onPressed: () {
          if (formKey.currentState!.validate()) {
            widget.user.name = _name.text;
            widget.user.role = _userRole ?? UserRole.driver;
            if (_tenant != null) {
              widget.user.tenantId = _tenant!.id;
            }
            if (widget.isEdit) {
              widget.userBloc.add(UpdateUser(widget.user.id, widget.user));
            } else {
              widget.userBloc.add(CreateUser(widget.user));
            }

            Navigator.pop(context);
          }
        },
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
