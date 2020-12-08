import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/helper/text_widget.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';

import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:shipanther/extensions/container_extension.dart';

class DriverContainerList extends StatefulWidget {
  final ContainerBloc containerBloc;
  final ContainersLoaded containerLoadedState;
  final api.User loggedInUser;
  const DriverContainerList(
    this.loggedInUser, {
    Key key,
    @required this.containerLoadedState,
    @required this.containerBloc,
  }) : super(key: key);

  @override
  _DriverContainerListState createState() => _DriverContainerListState();
}

class _DriverContainerListState extends State<DriverContainerList> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    var title = ShipantherLocalizations.of(context).containersTitle;
    List<Widget> actions = [];
    Widget body = ListView.builder(
      itemCount: _currentIndex == 0
          ? widget.containerLoadedState.containers
              .where((element) =>
                  element.status == api.ContainerStatus.accepted ||
                  element.status == api.ContainerStatus.assigned)
              .length
          : widget.containerLoadedState.containers
              .where((element) => element.status == api.ContainerStatus.arrived)
              .length,
      itemBuilder: (BuildContext context, int index) {
        var t = _currentIndex == 0
            ? widget.containerLoadedState.containers
                .where((element) =>
                    element.status == api.ContainerStatus.accepted ||
                    element.status == api.ContainerStatus.assigned)
                .elementAt(index)
            : widget.containerLoadedState.containers
                .where(
                    (element) => element.status == api.ContainerStatus.arrived)
                .elementAt(index);

        return Column(
          children: [
            ExpansionTile(
              leading: Icon(Icons.home_work),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy').format(t.reservationTime == null
                        ? DateTime.now()
                        : t.reservationTime),
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(204, 255, 0, 1)),
                  ),
                  Text(
                    DateFormat('kk:mm').format(t.reservationTime == null
                        ? DateTime.now()
                        : t.reservationTime),
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              title: Text(
                t.serialNumber,
                style: TextStyle(
                    color: t.status == api.ContainerStatus.accepted ||
                            t.status == api.ContainerStatus.assigned
                        ? t.status == api.ContainerStatus.assigned
                            ? Colors.red
                            : Colors.yellowAccent
                        : Colors.white,
                    fontSize: 20),
              ),
              subtitle: Text('${t.origin} to ${t.destination}'),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [textSpan('Size: ', t.size.text)],
                ),
                t.status == api.ContainerStatus.accepted
                    ? FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          t.status = api.ContainerStatus.arrived;
                          widget.containerBloc.add(UpdateContainer(t.id, t));
                        },
                        child: Text('Delivered'),
                      )
                    : Container(
                        width: 0,
                        height: 0,
                      ),
              ],
            ),
            t.status == api.ContainerStatus.assigned
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          t.status = api.ContainerStatus.accepted;
                          widget.containerBloc.add(UpdateContainer(t.id, t));
                        },
                        child: Text(
                          'Accept',
                        ),
                      ),
                      FlatButton(
                        color: Colors.red,
                        onPressed: () {
                          //TODO:Add Confirmation prompt
                          t.status = api.ContainerStatus.rejected;
                          t.driverId = null;
                          widget.containerBloc.add(UpdateContainer(t.id, t));
                        },
                        child: Text(
                          'Reject',
                        ),
                      )
                    ],
                  )
                : Container(
                    width: 0,
                    height: 0,
                  ),
          ],
        );
      },
    );
    Widget bottomNavigationBar = BottomNavigationBar(
      backgroundColor: Colors.white10,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      elevation: 1,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          label: 'Pending',
          icon: new Stack(
            children: <Widget>[
              new Icon(Icons.pending),
              new Positioned(
                right: 0,
                child: new Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 13,
                    minHeight: 13,
                  ),
                  child: new Text(
                    widget.containerLoadedState.containers
                        .where((element) =>
                            element.status == api.ContainerStatus.accepted)
                        .length
                        .toString(),
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
        BottomNavigationBarItem(
          label: 'Complete',
          icon: Icon(
            Icons.check,
            color: Colors.green,
          ),
        ),
      ],
    );

    return ShipantherScaffold(
      widget.loggedInUser,
      bottomNavigationBar: bottomNavigationBar,
      title: title,
      actions: actions,
      body: body,
      floatingActionButton: null,
    );
  }
}
