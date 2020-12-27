import 'package:flutter/material.dart';

import 'package:shipanther/bloc/shipment/shipment_bloc.dart';

import 'package:shipanther/l10n/shipanther_localization.dart';

import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:shipanther/extensions/shipment_extension.dart';

class DriverShipmentList extends StatefulWidget {
  const DriverShipmentList(
    this.loggedInUser, {
    Key key,
    @required this.shipmentsLoadedState,
    @required this.shipmentBloc,
  }) : super(key: key);
  final ShipmentBloc shipmentBloc;
  final ShipmentsLoaded shipmentsLoadedState;
  final api.User loggedInUser;

  @override
  _DriverShipmentListState createState() => _DriverShipmentListState();
}

class _DriverShipmentListState extends State<DriverShipmentList> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    void showAlertDialog(BuildContext context, api.Shipment t) {
      final Widget cancelButton = FlatButton(
        child: Text(ShipantherLocalizations.of(context).shipmentCancel),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      final Widget continueButton = FlatButton(
        child: Text(ShipantherLocalizations.of(context).shipmentReject),
        textColor: Colors.red,
        onPressed: () {
          t.status = api.ShipmentStatus.rejected;
          t.driverId = null;
          widget.shipmentBloc.add(UpdateShipment(t.id, t));
          Navigator.of(context).pop();
        },
      );

      final alert = AlertDialog(
        title: Text(ShipantherLocalizations.of(context).shipmentReject),
        content: Text(
            ShipantherLocalizations.of(context).shipmentRejectConfirmation),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      showDialog<AlertDialog>(
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

    final title = ShipantherLocalizations.of(context).shipmentsTitle(2);
    final actions = <Widget>[];
    final totalPending = widget.shipmentsLoadedState.shipments
        .where((element) => element.status == api.ShipmentStatus.accepted)
        .length;
    final items = _currentIndex == 0
        ? widget.shipmentsLoadedState.shipments.where((element) =>
            element.status == api.ShipmentStatus.accepted ||
            element.status == api.ShipmentStatus.assigned)
        : widget.shipmentsLoadedState.shipments
            .where((element) => element.status == api.ShipmentStatus.arrived);

    final body = items.isEmpty
        ? Center(
            child: Text(ShipantherLocalizations.of(context).shipmentNoItem))
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final t = items.elementAt(index);
              return Column(
                children: [
                  ExpansionTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.home_work),
                        Text(
                          t.size == null
                              ? api.ShipmentSize.n20sT.text
                              : t.size.text,
                          style: const TextStyle(
                            color: Color.fromRGBO(204, 255, 0, 1),
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ShipantherLocalizations.of(context)
                              .dateFormatter
                              .format(
                                t.reservationTime ?? DateTime.now(),
                              ),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(204, 255, 0, 1),
                          ),
                        ),
                        Text(
                          ShipantherLocalizations.of(context)
                              .timeFormatter
                              .format(
                                t.reservationTime ?? DateTime.now(),
                              ),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        Text(
                          t.serialNumber,
                          style: TextStyle(color: t.status.color, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Icon(
                          t.type == api.ShipmentType.incoming
                              ? Icons.arrow_circle_down_sharp
                              : Icons.arrow_circle_up_sharp,
                          size: 20,
                        )
                      ],
                    ),
                    subtitle: Text(ShipantherLocalizations.of(context)
                        .paramFromTo(t.origin, t.destination)),
                    children: [
                      if (t.status == api.ShipmentStatus.accepted)
                        FlatButton(
                          color: Colors.green,
                          onPressed: () {
                            t.status = api.ShipmentStatus.arrived;
                            widget.shipmentBloc.add(UpdateShipment(t.id, t));
                          },
                          child: Text(ShipantherLocalizations.of(context)
                              .shipmentDelivered),
                        )
                      else
                        Container(
                          width: 0,
                          height: 0,
                        ),
                    ],
                  ),
                  if (t.status == api.ShipmentStatus.assigned)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                          color: Colors.green,
                          onPressed: () {
                            t.status = api.ShipmentStatus.accepted;
                            widget.shipmentBloc.add(UpdateShipment(t.id, t));
                          },
                          child: Text(
                            ShipantherLocalizations.of(context).shipmentAccept,
                          ),
                        ),
                        FlatButton(
                          color: Colors.red,
                          onPressed: () {
                            showAlertDialog(context, t);
                          },
                          child: Text(
                            ShipantherLocalizations.of(context).shipmentReject,
                          ),
                        )
                      ],
                    )
                  else
                    Container(
                      width: 0,
                      height: 0,
                    ),
                ],
              );
            },
          );
    final Widget bottomNavigationBar = BottomNavigationBar(
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
          label: ShipantherLocalizations.of(context).shipmentPending,
          icon: Stack(
            children: <Widget>[
              const Icon(Icons.pending),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 13,
                    minHeight: 13,
                  ),
                  child: Text(
                    totalPending.toString(),
                    style: const TextStyle(
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
          label: ShipantherLocalizations.of(context).shipmentCompleted,
          icon: const Icon(
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
