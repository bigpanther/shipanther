import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:trober_sdk/api.dart';

class TenantList extends StatelessWidget {
  final TenantBloc tenantBloc;
  final TenantsLoaded tenantLoadedState;
  const TenantList({Key key, @required this.tenantLoadedState, this.tenantBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tenants"),
        actions: [
          FilterButton<TenantType>(
            possibleValues: TenantType.values,
            isActive: true,
            activeFilter: tenantLoadedState.tenantType,
            onSelected: (t) => context.read<TenantBloc>()..add(GetTenants(t)),
            tooltip: "Filter Tenant type",
          )
        ],
      ),
      body: ListView.builder(
        itemCount: tenantLoadedState.tenants.length,
        itemBuilder: (BuildContext context, int index) {
          var t = tenantLoadedState.tenants.elementAt(index);
          return ListTile(
            onTap: () => tenantBloc.add(GetTenant(t.id)),
            title: Text(
              t.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              "Created: ${t.createdAt}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          );
        },
      ),
    );
  }
}
