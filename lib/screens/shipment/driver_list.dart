import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shipanther/bloc/shipment/shipment_bloc.dart';

import 'package:shipanther/l10n/shipanther_localization.dart';

import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/shipment_extension.dart';

class DriverShipmentList extends StatefulWidget {
  const DriverShipmentList(
    this.loggedInUser, {
    Key? key,
    required this.shipmentsLoadedState,
    required this.shipmentBloc,
  }) : super(key: key);
  final ShipmentBloc shipmentBloc;
  final ShipmentsLoaded shipmentsLoadedState;
  final User loggedInUser;

  @override
  _DriverShipmentListState createState() => _DriverShipmentListState();
}

class _DriverShipmentListState extends State<DriverShipmentList> {
  int _currentIndex = 0;

  Future<void> handleDelivery(User driver, Shipment t) async {
    late PickedFile file;
    try {
      file = await ImagePicker()
          .getImage(source: ImageSource.camera, imageQuality: 50);
    } catch (e) {
      print('hsm $e');
    }
    //ignore:unnecessary_null_comparison
    if (file == null) {
      return;
    }
    final ref = FirebaseStorage.instance
        .ref()
        .child('files/${t.tenantId}/${t.customerId}')
        .child('/${t.id}.jpg');
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});
    late UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(File(file.path), metadata);
    }
    await uploadTask;
    t.status = ShipmentStatus.delivered;
    widget.shipmentBloc.add(UpdateShipment(t.id, t));
  }

  @override
  Widget build(BuildContext context) {
    void showAlertDialog(BuildContext context, Shipment t) {
      final Widget cancelButton = TextButton(
        child: Text(ShipantherLocalizations.of(context)!.shipmentCancel),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      final Widget continueButton = TextButton(
        child: Text(ShipantherLocalizations.of(context)!.shipmentReject),
        style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
        onPressed: () {
          t.status = ShipmentStatus.rejected;
          t.driverId = null;
          widget.shipmentBloc.add(UpdateShipment(t.id, t));
          Navigator.of(context).pop();
        },
      );

      final alert = AlertDialog(
        title: Text(ShipantherLocalizations.of(context)!.shipmentReject),
        content: Text(
            ShipantherLocalizations.of(context)!.shipmentRejectConfirmation),
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

    final title = ShipantherLocalizations.of(context)!.shipmentsTitle(2);
    final actions = <Widget>[];
    final totalPending = widget.shipmentsLoadedState.shipments
        .where((element) => element.status == ShipmentStatus.accepted)
        .length;
    final items = _currentIndex == 0
        ? widget.shipmentsLoadedState.shipments.where((element) =>
            element.status == ShipmentStatus.accepted ||
            element.status == ShipmentStatus.assigned)
        : widget.shipmentsLoadedState.shipments
            .where((element) => element.status == ShipmentStatus.delivered);

    final body = items.isEmpty
        ? Center(
            child: Text(ShipantherLocalizations.of(context)!.shipmentNoItem))
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
                              ? ShipmentSize.n20sT.text
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
                          ShipantherLocalizations.of(context)!
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
                          ShipantherLocalizations.of(context)!
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
                          style: TextStyle(
                              color: t.status.color(
                                  baseColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color),
                              fontSize: 20),
                        ),
                      ],
                    ),
                    subtitle: Text(ShipantherLocalizations.of(context)!
                        .paramFromTo(t.origin, t.destination)),
                    children: [
                      if (t.status == ShipmentStatus.accepted)
                        TextButton(
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () {
                            handleDelivery(widget.loggedInUser, t);
                          },
                          child: Text(ShipantherLocalizations.of(context)!
                              .shipmentDelivered),
                        )
                      else
                        Container(
                          width: 0,
                          height: 0,
                        ),
                    ],
                  ),
                  if (t.status == ShipmentStatus.assigned)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () {
                            t.status = ShipmentStatus.accepted;
                            widget.shipmentBloc.add(UpdateShipment(t.id, t));
                          },
                          child: Text(
                            ShipantherLocalizations.of(context)!.shipmentAccept,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).errorColor),
                          onPressed: () {
                            showAlertDialog(context, t);
                          },
                          child: Text(
                            ShipantherLocalizations.of(context)!.shipmentReject,
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
          label: ShipantherLocalizations.of(context)!.shipmentPending,
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
          label: ShipantherLocalizations.of(context)!.shipmentCompleted,
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
    );
  }
}
