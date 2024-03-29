import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/extensions/tenant_extension.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/locales/date_formatter.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:shipanther/widgets/uuid.dart';
import 'package:trober_sdk/trober_sdk.dart';

class TenantList extends StatelessWidget {
  const TenantList(
    this.loggedInUser, {
    Key? key,
    required this.tenantLoadedState,
    required this.tenantBloc,
  }) : super(key: key);
  final TenantBloc tenantBloc;
  final TenantsLoaded tenantLoadedState;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context).tenantsTitle(2);
    final actions = <Widget>[
      FilterButton<TenantType>(
        possibleValues: TenantType.values.toList(),
        isActive: true,
        activeFilter: tenantLoadedState.tenantType,
        onSelected: (t) => context.read<TenantBloc>().add(
              GetTenants(tenantType: t),
            ),
        tooltip: ShipantherLocalizations.of(context).tenantTypeFilter,
      )
    ];
    final Widget body = ListView.builder(
      itemCount: tenantLoadedState.tenants.length,
      itemBuilder: (BuildContext context, int index) {
        final t = tenantLoadedState.tenants.elementAt(index);
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
                    TenantAddEdit(
                      isEdit: true,
                      tenantBloc: tenantBloc,
                      tenant: t,
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
                displaySubtitle(ShipantherLocalizations.of(context).createdAt,
                    dateFormatter.format(t.createdAt.toLocal())),
                displaySubtitle(ShipantherLocalizations.of(context).lastUpdate,
                    dateFormatter.format(t.updatedAt.toLocal())),
              ],
            ),
          ),
        );
      },
    );

    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context).tenantAdd,
      onPressed: () {
        context.pushRoute(
          TenantAddEdit(
            isEdit: false,
            tenantBloc: tenantBloc,
            tenant: Tenant((b) => b
              ..name = ''
              ..type = TenantType.test
              ..code = ''
              ..createdAt = DateTime.now().toUtc()
              ..updatedAt = DateTime.now().toUtc()
              ..id = uuid()),
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
