import 'package:flutter/material.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;

class NoneHome extends StatelessWidget {
  final api.User user;
  const NoneHome(this.user, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(
      user,
      title: ShipantherLocalizations.of(context).tenantsTitle,
      actions: [],
      body: Container(
          child: Column(
        children: [
          Text('Hello ${user.name}'),
          Text(ShipantherLocalizations.of(context).tenantLessUserMessage),
        ],
      )),
      floatingActionButton: null,
    );
  }
}
