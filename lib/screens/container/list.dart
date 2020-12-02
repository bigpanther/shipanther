import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/helper/text_widget.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/container/add_edit.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;

class ContainerList extends StatelessWidget {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ContainerAddEdit(
                        loggedInUser,
                        isEdit: true,
                        containerBloc: containerBloc,
                        container: t,
                      ),
                    ),
                  );
                },
              ),

              expandedAlignment: Alignment.topLeft,
              title: Text(
                t.serialNumber,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text('${t.origin} to ${t.destination}'),
              children: [
                ExpansionTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textSpan(
                          'LFD: ',
                          DateFormat('dd-MM-yy - kk:mm').format(t.lfd),
                          Colors.white,
                          Color.fromRGBO(236, 77, 55, 1)),
                      textSpan(
                          'Reservation Time: ',
                          DateFormat('dd-MM-yy - kk:mm')
                              .format(t.reservationTime),
                          Colors.white,
                          Color.fromRGBO(0, 255, 0, 1)),
                    ],
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.topLeft,
                  childrenPadding: EdgeInsets.only(left: 16),
                  children: [
                    textSpan('Container size: ', t.size.toString(),
                        Colors.white, Colors.white),
                    textSpan('Container type: ', t.type.toString(),
                        Colors.white, Colors.white),
                    textSpan('Container status: ', t.status.toString(),
                        Colors.white, Colors.white),
                    textSpan('Updated: ', t.updatedAt.toString(), Colors.white,
                        Colors.white),
                  ],
                )
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
        Navigator.push(
          context,
          MaterialPageRoute(
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
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
