import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:shipanther/screens/order/order_search_delegate.dart';
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
      IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: OrderSearchDelegate(
              loggedInUser,
              context.read<OrderBloc>(),
            ),
          );
        },
        icon: const Icon(Icons.search),
      ),
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
    final Widget body =
        listbody(context, loggedInUser, orderBloc, orderLoadedState);

    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context).orderAdd,
      onPressed: () {
        context.pushRoute(
          OrderAddEdit(
              loggedInUser: loggedInUser,
              isEdit: false,
              orderBloc: orderBloc,
              order: Order((b) => b
                ..status = OrderStatus.open
                ..updatedAt = DateTime.now().toUtc()
                ..createdAt = DateTime.now().toUtc()
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
