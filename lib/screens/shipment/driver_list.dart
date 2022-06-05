import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipanther/bloc/shipment/shipment_bloc.dart';
import 'package:shipanther/extensions/shipment_extension.dart';
import 'package:shipanther/l10n/locales/date_formatter.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/trober_sdk.dart';

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
  DriverShipmentListState createState() => DriverShipmentListState();
}

class DriverShipmentListState extends State<DriverShipmentList> {
  int _currentIndex = 0;

  Future<void> handleDelivery(User driver, Shipment shipment) async {
    XFile? file;
    try {
      file = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } catch (e) {
      //print('hsm $e');
    }
    if (file == null) {
      return;
    }
    final ref = FirebaseStorage.instance
        .ref()
        .child('files/${shipment.tenantId}/${shipment.customerId}')
        .child('/${shipment.id}.jpg');
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
    shipment = shipment.rebuild((b) => b..status = ShipmentStatus.delivered);
    widget.shipmentBloc.add(UpdateShipment(shipment.id, shipment));
  }

  @override
  Widget build(BuildContext context) {
    void showAlertDialog(BuildContext context, Shipment shipment) {
      final Widget cancelButton = TextButton(
        onPressed: () {
          AutoRouter.of(context).pop();
        },
        child: Text(ShipantherLocalizations.of(context).shipmentCancel),
      );
      final Widget continueButton = TextButton(
        style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
        onPressed: () {
          shipment = shipment.rebuild((b) => b
            ..status = ShipmentStatus.rejected
            ..driverId = null);
          widget.shipmentBloc.add(UpdateShipment(shipment.id, shipment));
          AutoRouter.of(context).pop();
        },
        child: Text(ShipantherLocalizations.of(context).shipmentReject),
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
            child: Text(ShipantherLocalizations.of(context).shipmentNoItem))
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              var shipment = items.elementAt(index);
              return Column(
                children: [
                  ExpansionTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.home_work),
                        Text(
                          shipment.size == null
                              ? ShipmentSize.n20sT.name
                              : shipment.size?.name ?? '',
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
                          dateFormatter.format(
                            shipment.reservationTime ?? DateTime.now().toUtc(),
                          ),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(204, 255, 0, 1),
                          ),
                        ),
                        Text(
                          timeFormatter.format(
                            shipment.reservationTime ?? DateTime.now().toUtc(),
                          ),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        Text(
                          shipment.serialNumber,
                          style: TextStyle(
                              color: shipment.status.color(
                                  baseColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color),
                              fontSize: 20),
                        ),
                      ],
                    ),
                    subtitle: Text(ShipantherLocalizations.of(context)
                        .paramFromTo(
                            shipment.origin ?? '', shipment.destination ?? '')),
                    children: [
                      if (shipment.status == ShipmentStatus.accepted)
                        TextButton(
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () {
                            handleDelivery(widget.loggedInUser, shipment);
                          },
                          child: Text(ShipantherLocalizations.of(context)
                              .shipmentDelivered),
                        )
                      else
                        const SizedBox(
                          width: 0,
                          height: 0,
                        ),
                    ],
                  ),
                  if (shipment.status == ShipmentStatus.assigned)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () {
                            shipment = shipment.rebuild(
                                (b) => b..status = ShipmentStatus.accepted);
                            widget.shipmentBloc
                                .add(UpdateShipment(shipment.id, shipment));
                          },
                          child: Text(
                            ShipantherLocalizations.of(context).shipmentAccept,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).errorColor),
                          onPressed: () {
                            showAlertDialog(context, shipment);
                          },
                          child: Text(
                            ShipantherLocalizations.of(context).shipmentReject,
                          ),
                        )
                      ],
                    )
                  else
                    const SizedBox(
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
              _getPendingBlock(totalPending),
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
    );
  }

  Widget _getPendingBlock(int totalPendingItems) {
    if (totalPendingItems > 0) {
      return Positioned(
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
            totalPendingItems.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Container();
  }
}
