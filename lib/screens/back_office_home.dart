import 'package:flutter/material.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/trober_sdk.dart';

class BackOfficeHome extends StatelessWidget {
  const BackOfficeHome(this.user, {Key? key}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(
      user,
      title: ShipantherLocalizations.of(context)!.welcome,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  card(context, 'TODAY', 'UNASSIGNED', 'ASSIGNED', Colors.red),
                  card(context, 'TODAY', 'OUT FOR DELIVERY', 'DELIVERED',
                      Colors.yellow)
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  card(context, 'THIS MONTH', 'UNASSIGNED', 'ASSIGNED',
                      Colors.red),
                  card(context, 'THIS MONTH', 'OUT FOR DELIVERY', 'DELIVERED',
                      Colors.yellow),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Expanded card(BuildContext context, String _heading, String _subtitleOne,
    String _subtitleTwo, Color subOneColor) {
  return Expanded(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
              child: FittedBox(
                child: Text(
                  _heading,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
              child: FittedBox(
                child: Text(
                  '18',
                  style: TextStyle(
                    color: subOneColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
              child: FittedBox(
                child: Text(
                  _subtitleOne,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
              child: const FittedBox(
                child: Text(
                  '20',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
              child: FittedBox(
                child: Text(
                  _subtitleTwo,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
