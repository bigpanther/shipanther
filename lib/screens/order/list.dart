import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/order/add_edit.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class OrderList extends StatelessWidget {
  final OrderBloc orderBloc;
  final OrdersLoaded orderLoadedState;
  final User user;
  const OrderList(this.user,
      {Key key, @required this.orderLoadedState, this.orderBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    var title = ShipantherLocalizations.of(context).ordersTitle;
    List<Widget> actions = [
      // FilterButton<TerminalType>(
      //   possibleValues: TerminalType.values,
      //   isActive: true,
      //   activeFilter: terminalLoadedState.terminalType,
      //   onSelected: (t) => context.read<TerminalBloc>()..add(GetTerminals(t)),
      //   tooltip: "Filter Terminal type",
      // )
    ];

    Widget body = ListView.builder(
      itemCount: orderLoadedState.orders.length,
      itemBuilder: (BuildContext context, int index) {
        var t = orderLoadedState.orders.elementAt(index);
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
              leading: Icon(t.status == 'Open' ? Icons.check : Icons.clear),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => OrderAddEdit(
                  //       isEdit: true,
                  //       orderBloc: orderBloc,
                  //       order: t,
                  //     ),
                  //   ),
                  // );
                },
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              title: Text(
                t.customerId,
                style: Theme.of(context).textTheme.headline6,
              ),
              children: [
                Text(
                  "Created At: ${formatter.format(t.createdAt).toString()}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Created By: ${t.createdBy}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Last Update: ${formatter.format(t.updatedAt).toString()}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Tenant ID: ${t.tenantId}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        );
      },
    );
    Widget floatingActionButton = FloatingActionButton(
      tooltip: "Add terminal",
      child: Icon(Icons.add),
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => OrderAddEdit(
        //       isEdit: false,
        //       orderBloc: orderBloc,
        //       order: Order(),
        //     ),
        //   ),
        // );
      },
    );

    return ShipantherScaffold(user,
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
