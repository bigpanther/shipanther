import 'package:flutter/material.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/extensions/user_extension.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/selectors.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'package:shipanther/widgets/smart_select.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:trober_sdk/trober_sdk.dart';

class UserAddEdit extends StatefulWidget {
  const UserAddEdit(
    this.loggedInUser, {
    required this.user,
    required this.userBloc,
    required this.isEdit,
    super.key,
  });
  final User loggedInUser;
  final User user;
  final UserBloc userBloc;
  final bool isEdit;

  @override
  UserAddEditState createState() => UserAddEditState();
}

class UserAddEditState extends State<UserAddEdit> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
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
              ? ShipantherLocalizations.of(context)
                  .editParam(ShipantherLocalizations.of(context).usersTitle(1))
              : ShipantherLocalizations.of(context).addNewParam(
                  ShipantherLocalizations.of(context).usersTitle(1)),
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
                controller: _nameController,
                labelText: ShipantherLocalizations.of(context).userName,
                validator: (val) => val == null || val.trim().isEmpty
                    ? ShipantherLocalizations.of(context).paramEmpty(
                        ShipantherLocalizations.of(context).userName)
                    : null,
              ),
              smartSelect<UserRole>(
                context: context,
                title: ShipantherLocalizations.of(context).userType,
                onChange: (state) => _userRole = state.value,
                choiceItems: S2Choice.listFrom<UserRole, UserRole>(
                  source: UserRole.values.toList(),
                  value: (index, item) => item,
                  title: (index, item) => item.name,
                ),
                value: _userRole ?? widget.user.role,
              ),
              tenantSelector(
                  context, widget.isEdit && widget.loggedInUser.isSuperAdmin,
                  (Tenant suggestion) {
                _tenant = suggestion;
              }, _tenantTypeAheadController),
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
            var user = widget.user.rebuild((b) => b
              ..name = _nameController.text
              ..role = _userRole ?? UserRole.driver);
            if (_tenant != null) {
              user = user.rebuild((b) => b..tenantId = _tenant!.id);
            }
            if (widget.isEdit) {
              widget.userBloc.add(UpdateUser(user.id, user));
            } else {
              widget.userBloc.add(CreateUser(user));
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
    _nameController.dispose();
    _tenantTypeAheadController.dispose();
    super.dispose();
  }
}
