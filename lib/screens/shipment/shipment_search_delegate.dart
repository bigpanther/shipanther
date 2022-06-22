import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shipanther/bloc/shipment/shipment_bloc.dart';
import 'package:shipanther/extensions/shipment_extension.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:trober_sdk/trober_sdk.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/locales/date_formatter.dart';

class ShipmentSearchDelegate extends SearchDelegate<Shipment?> {
  final ShipmentBloc bloc;
  final User loggedInUser;

  ShipmentSearchDelegate(
    this.loggedInUser,
    this.bloc,
  );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Container();
    }
    bloc.add(SearchShipment(query));
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, ShipmentState state) {
        if (state is ShipmentLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ShipmentFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is ShipmentsLoaded) {
          return listbody(context, loggedInUser, bloc, state);
        }
        if (state is ShipmentNotFound) {
          return notFoundBody(context);
        }
        return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

Widget notFoundBody(BuildContext context) {
  return Center(
    child: Text(ShipantherLocalizations.of(context).notFound),
  );
}

Widget listbody(BuildContext context, User loggedInUser, ShipmentBloc bloc,
    ShipmentsLoaded state) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 500,
    ),
    itemCount: state.shipments.length,
    itemBuilder: (BuildContext context, int index) {
      final t = state.shipments.elementAt(index);
      final l10n = ShipantherLocalizations.of(context);

      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Card(
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: circularIndicator(t),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.pushRoute(
                      ShipmentAddEdit(
                        loggedInUser: loggedInUser,
                        isEdit: true,
                        shipmentBloc: bloc,
                        shipment: t,
                      ),
                    );
                  },
                ),
                title: Text(
                  t.serialNumber,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  displayProperty(
                    context,
                    l10n.reservationTime,
                    t.reservationTime,
                    formatter: dateTimeFormatter,
                    icon: Icons.timer,
                  ),
                  displayProperty(context, l10n.size, t.size?.name,
                      icon: Icons.photo_size_select_small),
                  displayProperty(context, l10n.status, t.status.name),
                  displayProperty(context, l10n.lastUpdate, t.updatedAt,
                      formatter: dateTimeFormatter),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget circularIndicator(Shipment c) {
  return CircularPercentIndicator(
    radius: 20.0,
    lineWidth: 5.0,
    percent: c.status.percentage,
    progressColor: Colors.green,
    center: Icon(c.type.icon),
  );
}
