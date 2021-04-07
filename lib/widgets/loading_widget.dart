import 'package:flutter/material.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/trober_sdk.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget(
      {Key? key, required this.loggedInUser, required this.title})
      : super(key: key);

  final User loggedInUser;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(loggedInUser,
        title: title, body: const CenteredLoading(), bottomNavigationBar: null);
  }
}
