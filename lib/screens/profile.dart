import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'package:trober_sdk/trober_sdk.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(this.user, {super.key});

  final User user;
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  late FormGroup usernameFormGroup;
  late FormGroup passwordFormGroup;
  @override
  void initState() {
    super.initState();
    usernameFormGroup = FormGroup({
      'name': FormControl<String>(
        value: widget.user.name,
        validators: [Validators.required],
      ),
    });
    usernameFormGroup = FormGroup(
      {
        'oldPassword': FormControl<String>(
          validators: [Validators.required],
        ),
        'newPassword': FormControl<String>(
          validators: [Validators.required],
        ),
        'confirmPassword': FormControl<String>(
          validators: [Validators.required],
        ),
      },
      validators: [Validators.mustMatch('newPassword', 'confirmPassword')],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(
      widget.user,
      title: ShipantherLocalizations.of(context).profile,
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 70,
                    child: ClipOval(
                      child: Icon(
                        Icons.person,
                        size: 70,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
              ReactiveForm(
                key: _formKeyName,
                formGroup: usernameFormGroup,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.user.name),
                      ],
                    ),
                    trailing: const Icon(Icons.edit),
                    childrenPadding: const EdgeInsets.only(left: 10, right: 10),
                    children: [
                      Column(
                        children: [
                          ShipantherTextFormField<String>(
                            formControlName: 'username',
                            labelText: ShipantherLocalizations.of(context).name,
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.text,
                            validationMessages: {
                              ValidationMessage.required:
                                  ShipantherLocalizations.of(context)
                                      .paramRequired(
                                          ShipantherLocalizations.of(context)
                                              .username),
                            },
                          ),
                          ShipantherButton(
                            onPressed: () {
                              if (usernameFormGroup.valid) {
                                var user = widget.user.rebuild((b) => b
                                  ..name = usernameFormGroup
                                      .control('username')
                                      .value);

                                context
                                    .read<UserBloc>()
                                    .add(UpdateUser(user.id, user));
                              }
                            },
                            labelText: ShipantherLocalizations.of(context).save,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ReactiveForm(
                key: _formKeyPassword,
                formGroup: passwordFormGroup,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text(
                        ShipantherLocalizations.of(context).changePassword),
                    trailing: const Icon(Icons.edit),
                    childrenPadding: const EdgeInsets.all(8),
                    children: [
                      Column(
                        children: [
                          ShipantherPasswordFormField(
                            formControlName: 'oldPassword',
                            labelText:
                                ShipantherLocalizations.of(context).oldPassword,
                            validationMessages: {
                              ValidationMessage.required:
                                  ShipantherLocalizations.of(context)
                                      .paramRequired(
                                          ShipantherLocalizations.of(context)
                                              .password)
                            },
                          ),
                          ShipantherPasswordFormField(
                            formControlName: 'newPassword',
                            labelText:
                                ShipantherLocalizations.of(context).newPassword,
                            validationMessages: {
                              ValidationMessage.required:
                                  ShipantherLocalizations.of(context)
                                      .paramRequired(
                                          ShipantherLocalizations.of(context)
                                              .password)
                            },
                          ),
                          ShipantherPasswordFormField(
                            formControlName: 'confirmPassword',
                            labelText: ShipantherLocalizations.of(context)
                                .confirmPassword,
                            validationMessages: {
                              ValidationMessage.required:
                                  ShipantherLocalizations.of(context)
                                      .paramRequired(
                                          ShipantherLocalizations.of(context)
                                              .password)
                            },
                          ),
                          ShipantherButton(
                            onPressed: () {
                              if (passwordFormGroup.valid) {
                                //print('not supported yet');
                                // context.read<AuthBloc>().add(UpdatePassword(
                                //     _oldPassword.text, _password.text));
                              }
                            },
                            labelText: ShipantherLocalizations.of(context)
                                .changePassword,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
