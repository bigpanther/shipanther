import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final api.User user;
  ProfilePage(this.user);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  String _updatedName;
  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(
      widget.user,
      title: ShipantherLocalizations.of(context).profile,
      actions: [],
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: <Widget>[
                  CircleAvatar(
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
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                        Text(_updatedName ?? widget.user.name),
                      ],
                    ),
                    trailing: Icon(Icons.edit),
                    childrenPadding: EdgeInsets.only(left: 10, right: 10),
                    children: [
                      Column(
                        children: [
                          TextFormField(
                            initialValue: _updatedName ?? widget.user.name,
                            decoration: InputDecoration(
                                labelText:
                                    ShipantherLocalizations.of(context).name),
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.text,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return ShipantherLocalizations.of(context)
                                    .paramRequired(
                                        ShipantherLocalizations.of(context)
                                            .username);
                              }

                              return null;
                            },
                            onSaved: (val) =>
                                setState(() => _updatedName = val),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            alignment: Alignment.center,
                            child: SignInButtonBuilder(
                              icon: Icons.save,
                              backgroundColor: Colors.blue,
                              onPressed: () async {
                                if (_formKeyName.currentState.validate()) {
                                  _formKeyName.currentState.save();
                                  widget.user.name = _updatedName;

                                  context.read<UserBloc>().add(
                                      UpdateUser(widget.user.id, widget.user));
                                }
                              },
                              text: ShipantherLocalizations.of(context).save,
                            ),
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
                    trailing: Icon(Icons.edit),
                    childrenPadding: EdgeInsets.all(8),
                    children: [
                      Column(
                        children: [
                          TextFormField(
                            controller: _oldPassword,
                            decoration: InputDecoration(
                                labelText: ShipantherLocalizations.of(context)
                                    .oldPassword),
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return ShipantherLocalizations.of(context)
                                    .paramRequired(
                                        ShipantherLocalizations.of(context)
                                            .password);
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _password,
                            decoration: InputDecoration(
                                labelText: ShipantherLocalizations.of(context)
                                    .newPassword),
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return ShipantherLocalizations.of(context)
                                    .paramRequired(
                                        ShipantherLocalizations.of(context)
                                            .password);
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _confirmPassword,
                            decoration: InputDecoration(
                                labelText: ShipantherLocalizations.of(context)
                                    .confirmPassword),
                            autocorrect: false,
                            enableSuggestions: false,
                            keyboardType: TextInputType.text,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return ShipantherLocalizations.of(context)
                                    .paramRequired(
                                        ShipantherLocalizations.of(context)
                                            .password);
                              }
                              if (value != _password.text) {
                                return ShipantherLocalizations.of(context)
                                    .passowrdDoesntMatch;
                              }
                              return null;
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            alignment: Alignment.center,
                            child: SignInButtonBuilder(
                              icon: Icons.lock,
                              backgroundColor: Colors.blue,
                              onPressed: () async {
                                if (_formKeyPassword.currentState.validate()) {
                                  context.read<AuthBloc>().add(UpdatePassword(
                                      _oldPassword.text, _password.text));
                                }
                              },
                              text: ShipantherLocalizations.of(context)
                                  .changePassword,
                            ),
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
      floatingActionButton: null,
      bottomNavigationBar: null,
    );
  }

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    _oldPassword.dispose();
    super.dispose();
  }
}
