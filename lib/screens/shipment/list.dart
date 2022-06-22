import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/shipment/shipment_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:shipanther/screens/shipment/shipment_search_delegate.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:shipanther/widgets/uuid.dart';
import 'package:trober_sdk/trober_sdk.dart';

class ShipmentList extends StatelessWidget {
  const ShipmentList(
    this.loggedInUser, {
    Key? key,
    required this.shipmentsLoadedState,
    required this.shipmentBloc,
  }) : super(key: key);
  final ShipmentBloc shipmentBloc;
  final ShipmentsLoaded shipmentsLoadedState;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context).shipmentsTitle(2);
    final actions = <Widget>[
      IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: ShipmentSearchDelegate(
              loggedInUser,
              context.read<ShipmentBloc>(),
            ),
          );
        },
        icon: const Icon(Icons.search),
      ),
      FilterButton<ShipmentStatus>(
        possibleValues: ShipmentStatus.values.toList(),
        isActive: true,
        activeFilter: shipmentsLoadedState.shipmentStatus,
        onSelected: (t) =>
            context.read<ShipmentBloc>()..add(GetShipments(shipmentStatus: t)),
        tooltip: ShipantherLocalizations.of(context).shipmentStatusFilter,
      )
    ];

    final Widget body =
        listbody(context, loggedInUser, shipmentBloc, shipmentsLoadedState);

    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context).shipmentAdd,
      onPressed: () {
        context.pushRoute(
          ShipmentAddEdit(
              loggedInUser: loggedInUser,
              isEdit: false,
              shipmentBloc: shipmentBloc,
              shipment: Shipment((b) => b
                ..status = ShipmentStatus.unassigned
                ..type = ShipmentType.inbound
                ..createdAt = DateTime.now().toUtc()
                ..updatedAt = DateTime.now().toUtc()
                ..id = uuid()
                ..serialNumber = ''
                ..tenantId = loggedInUser.tenantId)),
        );
      },
      child: const Icon(Icons.add),
    );

    return ShipantherScaffold(loggedInUser,
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
