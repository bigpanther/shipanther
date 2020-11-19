import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/tenant/add_edit.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class TenantList extends StatelessWidget {
  final TenantBloc tenantBloc;
  final TenantsLoaded tenantLoadedState;
  const TenantList({Key key, @required this.tenantLoadedState, this.tenantBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String todayDate = formatter.format(DateTime.now()).toString();
    var title = ShipantherLocalizations.of(context).tenantsTitle;
    List<Widget> actions = [
      FilterButton<TenantType>(
        possibleValues: TenantType.values,
        isActive: true,
        activeFilter: tenantLoadedState.tenantType,
        onSelected: (t) => context.read<TenantBloc>()..add(GetTenants(t)),
        tooltip: "Filter Tenant type",
      )
    ];
    Widget body = ListView.builder(
      itemCount: tenantLoadedState.tenants.length,
      itemBuilder: (BuildContext context, int index) {
        var t = tenantLoadedState.tenants.elementAt(index);
        // return ListTile(
        //   onTap: () => tenantBloc.add(GetTenant(t.id)),
        //   title: Text(
        //     t.name,
        //     style: Theme.of(context).textTheme.headline6,
        //   ),
        //   subtitle: Text(
        //     "Created: ${t.createdAt}",
        //     maxLines: 1,
        //     overflow: TextOverflow.ellipsis,
        //     style: Theme.of(context).textTheme.subtitle1,
        //   ),
        // );
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
              leading: Icon(Icons.local_shipping),
              trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => tenantBloc.add(GetTenant(t.id))),
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
              ],
            ),
          ),
        );
      },
    );

    Widget floatingActionButton = FloatingActionButton(
      tooltip: "Add tenant",
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TenantAddEdit(
              isEdit: false,
              tenantBloc: tenantBloc,
              tenant: Tenant(),
            ),
          ),
        );
      },
    );

    return ShipantherScaffold(
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
