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
        tooltip: "Filter Container status",
      )
    ];

    Widget body = ListView.builder(
      itemCount: widget.containerLoadedState.containers.length,
      itemBuilder: (BuildContext context, int index) {
        var t = widget.containerLoadedState.containers.elementAt(index);

        return Column(
          children: [
            ExpansionTile(
              childrenPadding: EdgeInsets.only(left: 20, bottom: 10),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home_work),
                  Text(
                    t.size == null ? 'N 20 s t' : t.size.text,
                    style: TextStyle(
                      color: Color.fromRGBO(204, 255, 0, 1),
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  widget.containerBloc.add(GetContainer(t.id));
                },
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              title: Row(
                children: [
                  Text(
                    t.serialNumber,
                    style: TextStyle(color: t.status.color, fontSize: 20),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Icon(
                    t.type == api.ContainerType.incoming
                        ? Icons.arrow_circle_down_sharp
                        : Icons.arrow_circle_up_sharp,
                    size: 20,
                  )
                ],
              ),
              subtitle: Text(
                t.reservationTime == null
                    ? 'NA'
                    : formatter.format(t.reservationTime).toString(),
              ),
              children: [
                Text(
                  " ${t.origin} to ${t.destination}",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(255, 131, 0, 1)),
                ),
                Text(
                  "Status: ${t.status.text}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            t.status == api.ContainerStatus.rejected
                ? FlatButton(
                    onPressed: () {
                      print('reassign');
                    },
                    child: Text('Re-assign'),
                    color: Colors.green,
                  )
                : Container(
                    height: 0,
                    width: 0,
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
