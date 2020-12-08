import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/carrier/carrier_bloc.dart';
import 'package:shipanther/extensions/carrier_extension.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/carrier/add_edit.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:shipanther/extensions/user_extension.dart';
import 'package:trober_sdk/api.dart';

class CarrierList extends StatelessWidget {
  final CarrierBloc carrierBloc;
  final CarriersLoaded carrierLoadedState;
  final User loggedInUser;
  const CarrierList(this.loggedInUser,
      {Key key, @required this.carrierLoadedState, this.carrierBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    var title = ShipantherLocalizations.of(context).carriersTitle;
    List<Widget> actions = [];

    Widget body = ListView.builder(
      itemCount: carrierLoadedState.carriers.length,
      itemBuilder: (BuildContext context, int index) {
        var t = carrierLoadedState.carriers.elementAt(index);
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
              leading: Icon(t.type.icon),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CarrierAddEdit(
                        loggedInUser,
                        isEdit: true,
                        carrierBloc: carrierBloc,
                        carrier: t,
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
                t.eta != null
                    ? Text(
                        "ETA: ${formatter.format(t.eta).toString()}",
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    : Text(''),
                Text(
                  "Created At: ${t.createdAt ?? formatter.format(t.createdAt).toString()}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Created By: ${t.createdBy}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Last Update: ${t.updatedAt ?? formatter.format(t.updatedAt).toString()}",
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
      tooltip: "Add carrier",
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CarrierAddEdit(
              loggedInUser,
              isEdit: false,
              carrierBloc: carrierBloc,
              carrier: Carrier(),
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
