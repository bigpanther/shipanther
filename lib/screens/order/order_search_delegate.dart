import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/extensions/shipment_extension.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:trober_sdk/trober_sdk.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/locales/date_formatter.dart';

class OrderSearchDelegate extends SearchDelegate<Shipment?> {
  final OrderBloc bloc;
  final User loggedInUser;

  OrderSearchDelegate(
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
    bloc.add(SearchOrder(query));
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, OrderState state) {
        if (state is OrderLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OrderFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is OrdersLoaded) {
          return listbody(context, loggedInUser, bloc, state);
        }
        if (state is OrderNotFound) {
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

Widget listbody(BuildContext context, User loggedInUser, OrderBloc bloc,
    OrdersLoaded state) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 500,
    ),
    itemCount: state.orders.length,
    itemBuilder: (BuildContext context, int index) {
      final t = state.orders.elementAt(index);
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
                leading: Icon(t.type?.icon),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.pushRoute(
                      OrderAddEdit(
                        loggedInUser: loggedInUser,
                        isEdit: true,
                        orderBloc: bloc,
                        order: t,
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
                    'Container Status',
                    t.containerStatus,
                  ),
                  displayProperty(
                    context,
                    'Shipline',
                    t.shipline,
                  ),
                  if (t.type == ShipmentType.inbound)
                    displayProperty(
                      context,
                      'ETA',
                      t.eta,
                      formatter: dateTimeFormatter,
                      icon: Icons.timer,
                    )
                  else
                    displayProperty(
                      context,
                      'ERD',
                      t.erd,
                      formatter: dateTimeFormatter,
                      icon: Icons.timer,
                    ),
                  if (t.type == ShipmentType.inbound)
                    displayProperty(
                      context,
                      'LFD',
                      t.lfd,
                      formatter: dateTimeFormatter,
                      icon: Icons.timer,
                    )
                  else
                    displayProperty(
                      context,
                      'DOC C/O',
                      t.docco,
                      formatter: dateTimeFormatter,
                      icon: Icons.timer,
                    ),
                  displayProperty(context, l10n.status, t.status.name),
                  displayProperty(context, 'SO#', t.soNumber),
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
