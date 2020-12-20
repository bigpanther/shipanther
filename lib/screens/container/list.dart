import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/container/add_edit.dart';
import 'package:shipanther/extensions/container_extension.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainerList extends StatelessWidget {
  const ContainerList(
    this.loggedInUser, {
    Key key,
    @required this.containerLoadedState,
    this.containerBloc,
  }) : super(key: key);
  final ContainerBloc containerBloc;
  final ContainersLoaded containerLoadedState;
  final api.User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context).containersTitle(2);
    final actions = <Widget>[
      FilterButton<api.ContainerStatus>(
        possibleValues: api.ContainerStatus.values,
        isActive: true,
        activeFilter: containerLoadedState.containerStatus,
        onSelected: (t) => context.read<ContainerBloc>()..add(GetContainers(t)),
        tooltip: 'Filter Order status',
      )
    ];
    Widget circularIndicator(api.Container c) {
      return CircularPercentIndicator(
        radius: 35.0,
        lineWidth: 5.0,
        percent: c.status.percentage,
        progressColor: Colors.green,
        center: Icon(c.type.icon),
      );
    }

    final Widget body = ListView.builder(
      itemCount: containerLoadedState.containers.length,
      itemBuilder: (BuildContext context, int index) {
        final t = containerLoadedState.containers.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            elevation: 1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: ExpansionTile(
              childrenPadding: const EdgeInsets.only(left: 20, bottom: 10),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  circularIndicator(t),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  containerBloc.add(GetContainer(t.id));
                },
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
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
              subtitle: Text(ShipantherLocalizations.of(context)
                  .paramFromTo(t.origin, t.destination)),
              children: [
                displaySubtitle(
                    ShipantherLocalizations.of(context).lfd,
                    t.lfd == null
                        ? ''
                        : ShipantherLocalizations.of(context)
                            .dateFormatter
                            .format(t.lfd)),
                displaySubtitle(
                    ShipantherLocalizations.of(context).reservationTime,
                    t.reservationTime == null
                        ? ''
                        : ShipantherLocalizations.of(context)
                            .dateFormatter
                            .format(t.reservationTime)),
                displaySubtitle(
                    ShipantherLocalizations.of(context).size, t.size.text),
                displaySubtitle(
                    ShipantherLocalizations.of(context).status, t.status.text),
                displaySubtitle(
                    ShipantherLocalizations.of(context).lastUpdate,
                    ShipantherLocalizations.of(context)
                        .dateFormatter
                        .format(t.updatedAt)),
              ],
            ),
          ),
        );
      },
    );

    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context).containerAdd,
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
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
        bottomNavigationBar: null,
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
