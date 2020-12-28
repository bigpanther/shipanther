import 'package:flutter/material.dart';

import 'package:shipanther/bloc/carrier/carrier_bloc.dart';
import 'package:shipanther/extensions/carrier_extension.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/carrier/add_edit.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:shipanther/extensions/user_extension.dart';
import 'package:trober_sdk/api.dart';

class CarrierList extends StatelessWidget {
  const CarrierList(this.loggedInUser,
      {Key? key, required this.carrierLoadedState, required this.carrierBloc})
      : super(key: key);
  final CarrierBloc carrierBloc;
  final CarriersLoaded carrierLoadedState;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context)!.carriersTitle(2);
    final actions = <Widget>[];

    final Widget body = ListView.builder(
      itemCount: carrierLoadedState.carriers.length,
      itemBuilder: (BuildContext context, int index) {
        final t = carrierLoadedState.carriers.elementAt(index);
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
              leading: Icon(t.type.icon),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
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
                if (t.eta != null)
                  displaySubtitle(
                      ShipantherLocalizations.of(context)!.eta,
                      ShipantherLocalizations.of(context)!
                          .dateFormatter
                          .format(t.eta))
                else
                  const Text(''),
                displaySubtitle(
                    ShipantherLocalizations.of(context)!.createdAt,
                    ShipantherLocalizations.of(context)!
                        .dateFormatter
                        .format(t.createdAt)),
                displaySubtitle(
                    ShipantherLocalizations.of(context)!.lastUpdate,
                    ShipantherLocalizations.of(context)!
                        .dateFormatter
                        .format(t.updatedAt)),
                if (loggedInUser.isSuperAdmin)
                  displaySubtitle(
                      ShipantherLocalizations.of(context)!.tenantId, t.tenantId)
                else
                  const Text(''),
              ],
            ),
          ),
        );
      },
    );
    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context)!.addCarrier,
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
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
        bottomNavigationBar: null,
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
