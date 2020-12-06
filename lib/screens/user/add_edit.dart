import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:shipanther/extensions/user_extension.dart';

class UserAddEdit extends StatefulWidget {
  final api.User loggedInUser;
  final api.User user;
  final UserBloc userBloc;
  final bool isEdit;

  UserAddEdit(
    this.loggedInUser, {
    Key key,
    @required this.user,
    @required this.userBloc,
    @required this.isEdit,
  });

  @override
  _UserAddEditState createState() => _UserAddEditState();
}

class _UserAddEditState extends State<UserAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _userName;
  api.UserRole _userRole;
  api.Tenant _tenant;
  final TextEditingController _tenantTypeAheadController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _userRole = widget.user.role ?? api.UserRole.driver;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? "Edit user" : "Add new user",
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
                      initialValue: widget.user.name ?? '',
                      autofocus: widget.isEdit ? false : true,
                      style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(hintText: 'User Name'),
                      validator: (val) => val.trim().isEmpty
                          ? "User name should not be empty"
                          : null,
                      onSaved: (value) => _userName = value,
                    ),
                    smartSelect<api.UserRole>(
                      title: "User type",
                      onChange: (state) => _userRole = state.value,
                      choiceItems:
                          S2Choice.listFrom<api.UserRole, api.UserRole>(
                        source: api.UserRole.values,
                        value: (index, item) => item,
                        title: (index, item) => item.text,
                      ),
                      value: _userRole,
                    ),
                    // Hack to avoid runtime type mismatch.
                    Container(width: 0.0, height: 0.0),
                  ] +
                  tenantSelector(context,
                      widget.isEdit && widget.loggedInUser.isSuperAdmin,
                      (api.Tenant suggestion) {
                    _tenant = suggestion;
                  }, _tenantTypeAheadController)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit
            ? ShipantherLocalizations.of(context).edit
            : ShipantherLocalizations.of(context).create,
        child: Icon(widget.isEdit ? Icons.check : Icons.add),
        onPressed: () async {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            widget.user.name = _userName;
            widget.user.role = _userRole ?? api.UserRole.driver;
            if (_tenant != null) {
              widget.user.tenantId = _tenant.id;
            }
            widget.user.createdBy =
                (await context.read<UserRepository>().self()).id;
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
}
