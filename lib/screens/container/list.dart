import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/container/add_edit.dart';
import 'package:shipanther/extensions/container_extension.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;

class ContainerList extends StatelessWidget {
  const ContainerList(
    this.loggedInUser, {
    Key key,
    @required this.containerLoadedState,
    this.containerBloc,
  }) : super(key: key);
  final ContainerBloc containerBloc;
  final ContainersLoaded containerLoadedState;
  final api.User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context).containersTitle;
    final actions = <Widget>[];
    Widget circularIndicator(double p) {
      return CircularPercentIndicator(
        radius: 35.0,
        lineWidth: 5.0,
        percent: p,
        // center: new Text("100%"),
        progressColor: Colors.green,
      );
    }

    final Widget body = ListView.builder(
      itemCount: containerLoadedState.containers.length,
      itemBuilder: (BuildContext context, int index) {
        final t = containerLoadedState.containers.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            elevation: 1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: ExpansionTile(
              childrenPadding: const EdgeInsets.only(left: 20, bottom: 10),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  circularIndicator(t.status.percentage),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  containerBloc.add(GetContainer(t.id));
                },
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              title: Text(
                t.serialNumber,
                style: TextStyle(color: t.status.color, fontSize: 20),
              ),
              subtitle: Text('${t.origin} to ${t.destination}'),
              children: [
                Text(
                  'LFD: ${t.lfd}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  'Reservation Time: ${t.reservationTime}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  'Size: ${t.size.text}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  'Status: ${t.status.text}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  'Last Update: ${ShipantherLocalizations.of(context).dateFormatter.format(t.updatedAt)}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        );
      },
    );

    final Widget floatingActionButton = FloatingActionButton(
      tooltip: 'Add container',
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => ContainerAddEdit(
              loggedInUser,
              isEdit: false,
              containerBloc: containerBloc,
              container: api.Container(),
            ),
          ),
        );
      },
    );

    return ShipantherScaffold(loggedInUser,
        bottomNavigationBar: null,
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
