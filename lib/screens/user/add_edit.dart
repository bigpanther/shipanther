import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
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
  late FormGroup formGroup;

  @override
  void initState() {
    super.initState();
    formGroup = FormGroup({
      'name': FormControl<String>(
        value: widget.user.name,
        validators: [Validators.required],
      ),
      'tenant': FormControl<Tenant>(
        // value: widget.user.tenant,
        validators: [Validators.required],
      ),
    });
  }

  UserRole? _userRole;

  @override
  Widget build(BuildContext context) {
    var l10n = ShipantherLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit
              ? l10n.editParam(l10n.usersTitle(1))
              : l10n.addNewParam(l10n.usersTitle(1)),
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
                  labelText: l10n.userName,
                  validationMessages: {
                    ValidationMessage.required: l10n.paramEmpty(l10n.userName)
                  }),
              smartSelect<UserRole>(
                context: context,
                title: l10n.userType,
                onChange: (state) => _userRole = state.value,
                choiceItems: S2Choice.listFrom<UserRole, UserRole>(
                  source: UserRole.values.toList(),
                  value: (index, item) => item,
                  title: (index, item) => item.name,
                ),
                value: _userRole ?? widget.user.role,
              ),
              tenantSelector(
                context,
                'tenant',
                !(widget.isEdit && widget.loggedInUser.isSuperAdmin),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: widget.isEdit ? l10n.edit : l10n.create,
        onPressed: () {
          if (formGroup.valid) {
            var user = widget.user.rebuild((b) => b
              ..name = formGroup.control('name').value
              ..role = _userRole ?? UserRole.driver);
            if (widget.loggedInUser.isSuperAdmin) {
              user = user.rebuild(
                  (b) => b..tenantId = formGroup.control('tenant').value.id);
            }
            if (widget.isEdit) {
              widget.userBloc.add(UpdateUser(user.id, user));
            } else {
              widget.userBloc.add(CreateUser(user));
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
