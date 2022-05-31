import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/extensions/order_extension.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/locales/date_formatter.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/screens/order/add_edit.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:shipanther/widgets/uuid.dart';
import 'package:trober_sdk/trober_sdk.dart';

class OrderList extends StatelessWidget {
  const OrderList(this.loggedInUser,
      {Key? key, required this.orderLoadedState, required this.orderBloc})
      : super(key: key);

  final OrderBloc orderBloc;
  final OrdersLoaded orderLoadedState;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context).ordersTitle(2);
    final actions = <Widget>[
      FilterButton<OrderStatus>(
          possibleValues: OrderStatus.values.toList(),
          isActive: true,
          activeFilter: orderLoadedState.orderStatus,
          onSelected: (t) => context.read<OrderBloc>()
            ..add(
              GetOrders(orderStatus: t),
            ),
          tooltip: ShipantherLocalizations.of(context).orderStatusFilter)
    ];

    final Widget body = ListView.builder(
      itemCount: orderLoadedState.orders.length,
      itemBuilder: (BuildContext context, int index) {
        final t = orderLoadedState.orders.elementAt(index);
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
              leading: Icon(t.status.icon),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  orderBloc.add(GetOrder(t.id));
                },
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              title: Text(
                t.serialNumber,
                style: Theme.of(context).textTheme.headline6,
              ),
              children: [
                displaySubtitle(ShipantherLocalizations.of(context).createdAt,
                    t.createdAt.toLocal(),
                    formatter: dateTimeFormatter),
                if (t.customer != null)
                  displaySubtitle(
                      ShipantherLocalizations.of(context).customerName,
                      t.customer?.name)
                else
                  const SizedBox(width: 0.0, height: 0.0),
                displaySubtitle(ShipantherLocalizations.of(context).lastUpdate,
                    t.updatedAt.toLocal(),
                    formatter: dateTimeFormatter),
              ],
            ),
          ),
        );
      },
    );
    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context).orderAdd,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => OrderAddEdit(loggedInUser,
                isEdit: false,
                orderBloc: orderBloc,
                order: Order((b) => b
                  ..status = OrderStatus.open
                  ..updatedAt = DateTime.now().toUtc()
                  ..createdAt = DateTime.now().toUtc()
                  ..id = uuid()
                  ..serialNumber = ''
                  ..tenantId = loggedInUser.tenantId)),
          ),
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
