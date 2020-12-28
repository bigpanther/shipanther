import 'package:flutter/material.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;

class BackOfficeHome extends StatefulWidget {
  const BackOfficeHome(this.user, {Key? key}) : super(key: key);

  final api.User user;

  @override
  _BackOfficeHomeState createState() => _BackOfficeHomeState();
}

class _BackOfficeHomeState extends State<BackOfficeHome> {
  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(
      widget.user,
      title: ShipantherLocalizations.of(context).welcome,
      actions: const [],
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  card('TODAY', 'UNASSIGNED', 'ASSIGNED', Colors.red),
                  card('TODAY', 'OUT FOR DELIVERY', 'DELIVERED', Colors.yellow)
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  card('THIS MONTH', 'UNASSIGNED', 'ASSIGNED', Colors.red),
                  card('THIS MONTH', 'OUT FOR DELIVERY', 'DELIVERED',
                      Colors.yellow),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: null,
      bottomNavigationBar: null,
    );
  }

  Expanded card(String _heading, String _subtitleOne, String _subtitleTwo,
      Color subOneColor) {
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
              Text(
                _heading,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
              Text(
                '18',
                style: TextStyle(
                  fontSize: 50,
                  color: subOneColor,
                ),
              ),
              Text(
                _subtitleOne,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Text(
                '20',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.green,
                ),
              ),
              Text(
                _subtitleTwo,
                style: const TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
