import 'package:flutter/material.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;

class ProfilePage extends StatefulWidget {
  final api.User user;
  ProfilePage(this.user);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(widget.user,
        title: ShipantherLocalizations.of(context).profile,
        actions: null,
        body: null,
        floatingActionButton: null);
  }
}
