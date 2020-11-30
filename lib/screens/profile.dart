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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password;
  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(widget.user,
        title: ShipantherLocalizations.of(context).profile,
        actions: [],
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: ShipantherLocalizations.of(context).password),
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return ShipantherLocalizations.of(context).paramRequired(
                          ShipantherLocalizations.of(context).password);
                    }
                    return null;
                  },
                  onSaved: (val) => setState(() => _password = val),
                ),
                Text(ShipantherLocalizations.of(context).resetPasswordMessage),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.email,
                    backgroundColor: Colors.green,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        context.read<AuthBloc>().add(UpdatePassword(_password));
                        Navigator.pop(context);
                      }
                    },
                    text: ShipantherLocalizations.of(context).resetPassword,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: null);
  }
}
