import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/customer/customer_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/customer/add_edit.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:shipanther/extensions/user_extension.dart';

import 'package:trober_sdk/api.dart';

class CustomerList extends StatelessWidget {
  final CustomerBloc customerBloc;
  final CustomersLoaded customerLoadedState;
  final User loggedInUser;
  const CustomerList(this.loggedInUser,
      {Key key, @required this.customerLoadedState, this.customerBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    var title = ShipantherLocalizations.of(context).customersTitle;
    List<Widget> actions = [];

    Widget body = ListView.builder(
      itemCount: customerLoadedState.customers.length,
      itemBuilder: (BuildContext context, int index) {
        var t = customerLoadedState.customers.elementAt(index);
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
              leading: Icon(Icons.people),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
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
                loggedInUser.isSuperAdmin
                    ? Text(
                        "Tenant ID: ${t.tenantId}",
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    : Text(''),
              ],
            ),
          ),
        );
      },
    );
    Widget floatingActionButton = FloatingActionButton(
      tooltip: "Add customer",
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
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
