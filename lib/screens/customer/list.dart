import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/bloc/customer/customer_bloc.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/locales/date_formatter.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/trober_sdk.dart';

import 'package:shipanther/widgets/uuid.dart';

class CustomerList extends StatelessWidget {
  const CustomerList(this.loggedInUser,
      {Key? key, required this.customerLoadedState, required this.customerBloc})
      : super(key: key);
  final CustomerBloc customerBloc;
  final CustomersLoaded customerLoadedState;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context).customersTitle(2);
    final actions = <Widget>[];

    final Widget body = ListView.builder(
      itemCount: customerLoadedState.customers.length,
      itemBuilder: (BuildContext context, int index) {
        final t = customerLoadedState.customers.elementAt(index);
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
              leading: const Icon(Icons.people),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  context.pushRoute(
                    CustomerAddEdit(
                      loggedInUser: loggedInUser,
                      isEdit: true,
                      customerBloc: customerBloc,
                      customer: t,
                    ),
                  );
                },
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              title: Text(
                t.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              children: [
                displayProperty(context,
                    ShipantherLocalizations.of(context).createdAt, t.createdAt,
                    formatter: dateTimeFormatter),
                displayProperty(context,
                    ShipantherLocalizations.of(context).lastUpdate, t.updatedAt,
                    formatter: dateTimeFormatter),
              ],
            ),
          ),
        );
      },
    );
    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context).addCustomer,
      onPressed: () {
        context.pushRoute(
          CustomerAddEdit(
            loggedInUser: loggedInUser,
            isEdit: false,
            customerBloc: customerBloc,
            customer: Customer((b) => b
              ..createdAt = DateTime.now().toUtc()
              ..updatedAt = DateTime.now().toUtc()
              ..id = uuid()
              ..name = ''
              ..tenantId = loggedInUser.tenantId),
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
