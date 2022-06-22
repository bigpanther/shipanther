import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/bloc/carrier/carrier_bloc.dart';
import 'package:shipanther/extensions/carrier_extension.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/locales/date_formatter.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:shipanther/widgets/uuid.dart';
import 'package:trober_sdk/trober_sdk.dart';

class CarrierList extends StatelessWidget {
  const CarrierList(this.loggedInUser,
      {Key? key, required this.carrierLoadedState, required this.carrierBloc})
      : super(key: key);
  final CarrierBloc carrierBloc;
  final CarriersLoaded carrierLoadedState;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context).carriersTitle(2);
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
                  context.pushRoute(
                    CarrierAddEdit(
                      loggedInUser: loggedInUser,
                      isEdit: true,
                      carrierBloc: carrierBloc,
                      carrier: t,
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
                displayProperty(
                    context, ShipantherLocalizations.of(context).eta, t.eta,
                    formatter: dateTimeFormatter),
                displayProperty(
                    context,
                    ShipantherLocalizations.of(context).createdAt,
                    t.createdAt?.toLocal(),
                    formatter: dateTimeFormatter),
                displayProperty(
                    context,
                    ShipantherLocalizations.of(context).lastUpdate,
                    t.updatedAt?.toLocal(),
                    formatter: dateTimeFormatter),
              ],
            ),
          ),
        );
      },
    );
    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context).addCarrier,
      onPressed: () {
        context.pushRoute(
          CarrierAddEdit(
            loggedInUser: loggedInUser,
            isEdit: false,
            carrierBloc: carrierBloc,
            carrier: Carrier((b) => b
              ..type = CarrierType.vessel
              ..name = ''
              ..id = uuid()
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
