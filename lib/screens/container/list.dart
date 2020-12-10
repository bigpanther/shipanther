import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/container/add_edit.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:shipanther/extensions/container_extension.dart';

class ContainerList extends StatefulWidget {
  final ContainerBloc containerBloc;
  final ContainersLoaded containerLoadedState;
  final api.User loggedInUser;
  const ContainerList(
    this.loggedInUser, {
    Key key,
    @required this.containerLoadedState,
    this.containerBloc,
  }) : super(key: key);

  @override
  _ContainerListState createState() => _ContainerListState();
}

class _ContainerListState extends State<ContainerList> {
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy - kk:mm');

    var title = ShipantherLocalizations.of(context).containersTitle;
    List<Widget> actions = [
      FilterButton<api.ContainerStatus>(
        possibleValues: api.ContainerStatus.values,
        isActive: true,
        activeFilter: widget.containerLoadedState.containerStatus,
        onSelected: (t) => context.read<ContainerBloc>()..add(GetContainers(t)),
        tooltip: "Filter Order status",
      )
    ];

    Widget body = ListView.builder(
      itemCount: widget.containerLoadedState.containers.length,
      itemBuilder: (BuildContext context, int index) {
        var t = widget.containerLoadedState.containers.elementAt(index);
        return ExpansionTile(
          childrenPadding: EdgeInsets.only(left: 20, bottom: 10),
          leading: Icon(Icons.home_work),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              widget.containerBloc.add(GetContainer(t.id));
            },
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          title: Text(
            t.serialNumber,
            style: TextStyle(color: t.status.color, fontSize: 20),
          ),
          // subtitle: Text('${t.origin} to ${t.destination}'),
          subtitle: Text(
            formatter.format(t.createdAt).toString(),
            style: TextStyle(
              color: Color.fromRGBO(204, 255, 0, 1),
            ),
          ),
          children: [
            Text(
              "LFD: ${t.status}",
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
        );
      },
    );

    Widget floatingActionButton = FloatingActionButton(
      tooltip: "Add container",
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ContainerAddEdit(
              widget.loggedInUser,
              isEdit: false,
              containerBloc: widget.containerBloc,
              container: api.Container(),
            ),
          ),
        );
      },
    );

    return ShipantherScaffold(widget.loggedInUser,
        bottomNavigationBar: null,
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
