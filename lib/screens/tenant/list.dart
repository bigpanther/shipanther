import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/tenant/add_edit.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/tenant_extension.dart';

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
    final title = ShipantherLocalizations.of(context)!.tenantsTitle(2);
    final actions = <Widget>[
      FilterButton<TenantType>(
        possibleValues: TenantType.values,
        isActive: true,
        activeFilter: tenantLoadedState.tenantType,
        onSelected: (t) => context.read<TenantBloc>().add(
              GetTenants(tenantType: t),
            ),
        tooltip: ShipantherLocalizations.of(context)!.tenantTypeFilter,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => TenantAddEdit(
                        isEdit: true,
                        tenantBloc: tenantBloc,
                        tenant: t,
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
                    ShipantherLocalizations.of(context)!.createdAt,
                    ShipantherLocalizations.of(context)!
                        .dateFormatter
                        .format(t.createdAt)),
                displaySubtitle(
                    ShipantherLocalizations.of(context)!.lastUpdate,
                    ShipantherLocalizations.of(context)!
                        .dateFormatter
                        .format(t.updatedAt)),
              ],
            ),
          ),
        );
      },
    );

    final Widget floatingActionButton = FloatingActionButton(
      tooltip: ShipantherLocalizations.of(context)!.tenantAdd,
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => TenantAddEdit(
              isEdit: false,
              tenantBloc: tenantBloc,
              tenant: Tenant(),
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
