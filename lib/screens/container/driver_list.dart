import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';

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
    showAlertDialog(BuildContext context, api.Container t) {
      Widget cancelButton = FlatButton(
        child: Text(ShipantherLocalizations.of(context).cancel),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = FlatButton(
        child: Text(ShipantherLocalizations.of(context).reject),
        textColor: Colors.red,
        onPressed: () {
          t.status = api.ContainerStatus.rejected;
          t.driverId = null;
          widget.containerBloc.add(UpdateContainer(t.id, t));
          Navigator.of(context).pop();
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text(ShipantherLocalizations.of(context).reject),
        content: Text(
            ShipantherLocalizations.of(context).containerRejectConfirmation),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    var title = ShipantherLocalizations.of(context).containersTitle;
    List<Widget> actions = [];
    var totalPending = widget.containerLoadedState.containers
        .where((element) => element.status == api.ContainerStatus.accepted)
        .length;
    var items = _currentIndex == 0
        ? widget.containerLoadedState.containers.where((element) =>
            element.status == api.ContainerStatus.accepted ||
            element.status == api.ContainerStatus.assigned)
        : widget.containerLoadedState.containers
            .where((element) => element.status == api.ContainerStatus.arrived);

    Widget body = items.length == 0
        ? Center(child: Text("No items here"))
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              var t = items.elementAt(index);
              return Column(
                children: [
                  ExpansionTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_work),
                        Text(
                          t.size == null
                              ? api.ContainerSize.n20sT
                              : t.size.text,
                          style: TextStyle(
                            color: Color.fromRGBO(204, 255, 0, 1),
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('dd-MM-yyyy').format(
                              t.reservationTime == null
                                  ? DateTime.now()
                                  : t.reservationTime),
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(204, 255, 0, 1)),
                        ),
                        Text(
                          DateFormat('kk:mm').format(t.reservationTime == null
                              ? DateTime.now()
                              : t.reservationTime),
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
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
                    subtitle: Text('${t.origin} to ${t.destination}'),
                    children: [
                      t.status == api.ContainerStatus.accepted
                          ? FlatButton(
                              color: Colors.green,
                              onPressed: () {
                                t.status = api.ContainerStatus.arrived;
                                widget.containerBloc
                                    .add(UpdateContainer(t.id, t));
                              },
                              child: Text(ShipantherLocalizations.of(context)
                                  .delivered),
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
                                widget.containerBloc
                                    .add(UpdateContainer(t.id, t));
                              },
                              child: Text(
                                ShipantherLocalizations.of(context).accept,
                              ),
                            ),
                            FlatButton(
                              color: Colors.red,
                              onPressed: () {
                                showAlertDialog(context, t);
                              },
                              child: Text(
                                ShipantherLocalizations.of(context).reject,
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
          label: ShipantherLocalizations.of(context).pending,
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
                    totalPending.toString(),
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
          label: ShipantherLocalizations.of(context).completed,
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
