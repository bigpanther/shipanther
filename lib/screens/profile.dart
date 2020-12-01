import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
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
  String _password;
  String _confirmPassword;
  String _updatedName;
  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(widget.user,
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
                        children: [
                          Text('Username: '),
                          Text(_updatedName == null
                              ? widget.user.name
                              : _updatedName),
                        ],
                      ),
                      trailing: Icon(Icons.edit),
                      childrenPadding: EdgeInsets.only(left: 10, right: 10),
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              initialValue: _updatedName == null
                                  ? widget.user.name
                                  : _updatedName,
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
                                              .password);
                                }

                                return null;
                              },
                              onSaved: (val) =>
                                  setState(() => _updatedName = val),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              alignment: Alignment.center,
                              child: SignInButtonBuilder(
                                icon: Icons.save,
                                backgroundColor: Colors.blue,
                                onPressed: () async {
                                  if (_formKeyName.currentState.validate()) {
                                    _formKeyName.currentState.save();

                                    context
                                        .read<AuthBloc>()
                                        .add(UpdateName(_updatedName));
                                  }
                                },
                                text: 'Save',
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
                      title: Text('Password'),
                      trailing: Icon(Icons.edit),
                      childrenPadding: EdgeInsets.all(8),
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: ShipantherLocalizations.of(context)
                                      .password),
                              autocorrect: false,
                              enableSuggestions: false,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return ShipantherLocalizations.of(context)
                                      .paramRequired(
                                          ShipantherLocalizations.of(context)
                                              .password);
                                }
                                if (_confirmPassword != null &&
                                    value != _confirmPassword) {
                                  return 'Password does not match';
                                }
                                return null;
                              },
                              onSaved: (val) => setState(() => _password = val),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: ShipantherLocalizations.of(context)
                                      .password),
                              autocorrect: false,
                              enableSuggestions: false,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return ShipantherLocalizations.of(context)
                                      .paramRequired(
                                          ShipantherLocalizations.of(context)
                                              .password);
                                }
                                if (value != _password) {
                                  return 'Password does not match';
                                }
                                return null;
                              },
                              onSaved: (val) =>
                                  setState(() => _confirmPassword = val),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              alignment: Alignment.center,
                              child: SignInButtonBuilder(
                                icon: Icons.lock,
                                backgroundColor: Colors.blue,
                                onPressed: () async {
                                  if (_formKeyPassword.currentState
                                      .validate()) {
                                    _formKeyPassword.currentState.save();

                                    context
                                        .read<AuthBloc>()
                                        .add(UpdatePassword(_password));
                                  }
                                },
                                text: ShipantherLocalizations.of(context)
                                    .resetPassword,
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
        floatingActionButton: null);
  }
}
