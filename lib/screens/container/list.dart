import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class ContainerList extends StatelessWidget {
  final ContainerBloc containerBloc;
  final ContainersLoaded containerLoadedState;
  final User loggedInUser;
  const ContainerList(
    this.loggedInUser, {
    Key key,
    @required this.containerLoadedState,
    this.containerBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    var title = ShipantherLocalizations.of(context).containersTitle;
    List<Widget> actions = [];
    Widget body = ListView.builder(
      itemCount: containerLoadedState.containers.length,
      itemBuilder: (BuildContext context, int index) {
        var t = containerLoadedState.containers.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.only(left: 20, bottom: 10),
              // subtitle: Text(t.id),
              // tilePadding: EdgeInsets.all(5),
              leading: Icon(Icons.home_work),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => ContainerAddEdit(
                  //       isEdit: true,
                  //       containerBloc: containerBloc,
                  //       container: t,
                  //     ),
                  //   ),
                  // );
                },
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              title: Text(
                t.serialNumber,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(t.origin + ' to ' + t.destination),
              children: [
                Text(
                  "LFD: ${t.lfd}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Reservation Time: ${t.reservationTime}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Created At: ${formatter.format(t.createdAt).toString()}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Created By: ${t.createdBy}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Last Update: ${formatter.format(t.updatedAt).toString()}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        );
      },
    );

    Widget floatingActionButton = FloatingActionButton(
      tooltip: "Add container",
      child: Icon(Icons.add),
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => ContainerAddEdit(
        //       isEdit: false,
        //       containerBloc: containerBloc,
        //       container: Container(),
        //     ),
        //   ),
        // );
      },
    );

    return ShipantherScaffold(loggedInUser,
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
