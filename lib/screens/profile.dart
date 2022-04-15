import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'package:trober_sdk/api.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(this.user, {super.key});

  final User user;
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  late TextEditingController _username;
  @override
  void initState() {
    super.initState();
    _username = TextEditingController(text: widget.user.name);
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
              Form(
                key: _formKeyName,
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
                          ShipantherTextFormField(
                            controller: _username,
                            labelText: ShipantherLocalizations.of(context).name,
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return ShipantherLocalizations.of(context)
                                    .paramRequired(
                                        ShipantherLocalizations.of(context)
                                            .username);
                              }
                              return null;
                            },
                          ),
                          ShipantherButton(
                            onPressed: () {
                              if (_formKeyName.currentState!.validate()) {
                                widget.user.name = _username.text;

                                context.read<UserBloc>().add(
                                    UpdateUser(widget.user.id, widget.user));
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
              Form(
                key: _formKeyPassword,
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
                            controller: _oldPassword,
                            labelText:
                                ShipantherLocalizations.of(context).oldPassword,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return ShipantherLocalizations.of(context)
                                    .paramRequired(
                                        ShipantherLocalizations.of(context)
                                            .password);
                              }
                              return null;
                            },
                          ),
                          ShipantherPasswordFormField(
                            controller: _password,
                            labelText:
                                ShipantherLocalizations.of(context).newPassword,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return ShipantherLocalizations.of(context)
                                    .paramRequired(
                                        ShipantherLocalizations.of(context)
                                            .password);
                              }
                              return null;
                            },
                          ),
                          ShipantherPasswordFormField(
                            controller: _confirmPassword,
                            labelText: ShipantherLocalizations.of(context)
                                .confirmPassword,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return ShipantherLocalizations.of(context)
                                    .paramRequired(
                                        ShipantherLocalizations.of(context)
                                            .password);
                              }
                              if (value != _password.text) {
                                return ShipantherLocalizations.of(context)
                                    .passwordDoesntMatch;
                              }
                              return null;
                            },
                          ),
                          ShipantherButton(
                            onPressed: () {
                              if (_formKeyPassword.currentState!.validate()) {
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

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _oldPassword.dispose();
    super.dispose();
  }
}
