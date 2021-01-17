import 'package:flutter/material.dart';
import 'package:shipanther/bloc/customer/customer_bloc.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/customer/add_edit.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';

import 'package:trober_sdk/api.dart';

class CustomerList extends StatelessWidget {
  const CustomerList(this.loggedInUser,
      {Key? key, required this.customerLoadedState, required this.customerBloc})
      : super(key: key);
  final CustomerBloc customerBloc;
  final CustomersLoaded customerLoadedState;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context)!.customersTitle(2);
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
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => CustomerAddEdit(
                        loggedInUser,
                        isEdit: true,
                        customerBloc: customerBloc,
                        customer: t,
                      ),
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
                displaySubtitle(
                    ShipantherLocalizations.of(context)!.createdAt, t.createdAt,
                    formatter:
                        ShipantherLocalizations.of(context)!.dateTimeFormatter),
                displaySubtitle(ShipantherLocalizations.of(context)!.lastUpdate,
                    t.updatedAt,
                    formatter:
                        ShipantherLocalizations.of(context)!.dateTimeFormatter),
              ],
            ),
          ),
        );
      },
    );
    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context)!.addCustomer,
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => CustomerAddEdit(
              loggedInUser,
              isEdit: false,
              customerBloc: customerBloc,
              customer: Customer(),
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
