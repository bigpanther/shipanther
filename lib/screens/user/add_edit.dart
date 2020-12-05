import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:smart_select/smart_select.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/user_extension.dart';

class UserAddEdit extends StatefulWidget {
  final User loggedInUser;
  final User user;
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
  UserRole _userRole;
  Tenant _tenant;

  @override
  Widget build(BuildContext context) {
    _userRole = widget.user.role ?? UserRole.driver;
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
                    SmartSelect<UserRole>.single(
                      title: "User type",
                      onChange: (state) => _userRole = state.value,
                      choiceItems: S2Choice.listFrom<UserRole, UserRole>(
                        source: UserRole.values,
                        value: (index, item) => item,
                        title: (index, item) => item.text,
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
                      value: _userRole,
                    ),
                  ] +
                  tenantSelector(context,
                      widget.isEdit && widget.loggedInUser.isSuperAdmin,
                      (Tenant suggestion) {
                    _tenant = suggestion;
                  })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit ? "Edit" : "Create",
        child: Icon(widget.isEdit ? Icons.check : Icons.add),
        onPressed: () async {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            widget.user.name = _userName;
            widget.user.role = _userRole ?? UserRole.driver;
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
