import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shipanther/bloc/container/container_bloc.dart';

import 'package:shipanther/l10n/shipanther_localization.dart';

import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:shipanther/extensions/container_extension.dart';

class DriverContainerList extends StatefulWidget {
  const DriverContainerList(
    this.loggedInUser, {
    Key key,
    @required this.containerLoadedState,
    @required this.containerBloc,
  }) : super(key: key);
  final ContainerBloc containerBloc;
  final ContainersLoaded containerLoadedState;
  final api.User loggedInUser;

  @override
  _DriverContainerListState createState() => _DriverContainerListState();
}

class _DriverContainerListState extends State<DriverContainerList> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    File _image;
    final picker = ImagePicker();

    Future getImage() async {
      final pickedImage = await picker.getImage(source: ImageSource.camera);

      if (pickedImage == null) {
        return;
      }

      var tmpFile = File(pickedImage.path);
      tmpFile = await tmpFile.copy(tmpFile.path);

      setState(() {
        _image = tmpFile;
      });
    }

    void showAlertDialog(BuildContext context, api.Container t) {
      final Widget cancelButton = FlatButton(
        child: Text(ShipantherLocalizations.of(context).cancel),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      final Widget continueButton = FlatButton(
        child: Text(ShipantherLocalizations.of(context).reject),
        textColor: Colors.red,
        onPressed: () {
          t.status = api.ContainerStatus.rejected;
          t.driverId = null;
          widget.containerBloc.add(UpdateContainer(t.id, t));
          Navigator.of(context).pop();
        },
      );

      final alert = AlertDialog(
        title: Text(ShipantherLocalizations.of(context).reject),
        content: Text(
            ShipantherLocalizations.of(context).containerRejectConfirmation),
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

    final title = ShipantherLocalizations.of(context).containersTitle;
    final actions = <Widget>[];
    final totalPending = widget.containerLoadedState.containers
        .where((element) => element.status == api.ContainerStatus.accepted)
        .length;
    final items = _currentIndex == 0
        ? widget.containerLoadedState.containers.where((element) =>
            element.status == api.ContainerStatus.accepted ||
            element.status == api.ContainerStatus.assigned)
        : widget.containerLoadedState.containers
            .where((element) => element.status == api.ContainerStatus.arrived);

    final body = items.isEmpty
        ? const Center(child: Text('No items here'))
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
                              ? api.ContainerSize.n20sT.text
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
                          t.type == api.ContainerType.incoming
                              ? Icons.arrow_circle_down_sharp
                              : Icons.arrow_circle_up_sharp,
                          size: 20,
                        )
                      ],
                    ),
                    subtitle: Text('${t.origin} to ${t.destination}'),
                    children: [
                      if (t.status == api.ContainerStatus.accepted)
                        FlatButton(
                          color: Colors.green,
                          onPressed: () {
                            t.status = api.ContainerStatus.arrived;
                            widget.containerBloc.add(UpdateContainer(t.id, t));
                          },
                          child: Text(
                              ShipantherLocalizations.of(context).delivered),
                        )
                      else
                        Container(
                          width: 0,
                          height: 0,
                        ),
                    ],
                  ),
                  if (t.status == api.ContainerStatus.assigned)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                          color: Colors.green,
                          onPressed: () {
                            t.status = api.ContainerStatus.accepted;
                            widget.containerBloc.add(UpdateContainer(t.id, t));
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
          label: ShipantherLocalizations.of(context).pending,
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
          label: ShipantherLocalizations.of(context).completed,
          icon: const Icon(
            Icons.check,
            color: Colors.green,
          ),
        ),
      ],
    );
    final Widget floatingActionButton = FloatingActionButton(
      onPressed: getImage,
      tooltip: 'Pick Image',
      child: const Icon(Icons.add_a_photo),
    );

    return ShipantherScaffold(
      widget.loggedInUser,
      bottomNavigationBar: bottomNavigationBar,
      title: title,
      actions: actions,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
