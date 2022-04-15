import 'package:flutter/material.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class NoneHome extends StatelessWidget {
  const NoneHome(this.user, {Key? key}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(
      user,
      title: ShipantherLocalizations.of(context).shipantherTitle,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(ShipantherLocalizations.of(context).helloParam(user.name)),
          Text(ShipantherLocalizations.of(context).tenantLessUserMessage),
        ],
      ),
    );
  }
}
