import 'package:flutter/material.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class NoneHome extends StatelessWidget {
  const NoneHome(this.user, {Key? key}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(
      user,
      bottomNavigationBar: null,
      title: ShipantherLocalizations.of(context)!.tenantsTitle(2),
      actions: const [],
      body: Container(
        child: Column(
          children: [
            Text(ShipantherLocalizations.of(context)!.helloParam(user.name)),
            Text(ShipantherLocalizations.of(context)!.tenantLessUserMessage),
          ],
        ),
      ),
      floatingActionButton: null,
    );
  }
}
