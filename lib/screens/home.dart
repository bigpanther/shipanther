import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:trober_sdk/api.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<TenantBloc>().add(GetTenants(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TenantBloc, TenantState>(
      listener: (context, state) {
        if (state is TenantFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Home()));
        }
      },
      builder: (context, state) {
        print(state);
        if (state is TenantLoading ||
            state is TenantInitial ||
            state is TenantFailure) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Tenants"),
            ),
            body: CenteredLoading(),
          );
        }
        if (state is TenantsLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Tenants"),
              actions: [
                FilterButton<TenantType>(
                  possibleValues: TenantType.values,
                  isActive: true,
                  activeFilter: state.tenantType,
                  onSelected: (t) =>
                      context.read<TenantBloc>().add(GetTenants(t)),
                  tooltip: "Filter Tenant type",
                )
              ],
            ),
            body: ListView.builder(
              itemCount: state.tenants.length,
              itemBuilder: (BuildContext context, int index) {
                var t = state.tenants.elementAt(index);
                return ListTile(
                  onTap: () => context.read<TenantBloc>().add(GetTenant(t.id)),
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
        if (state is TenantLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Tenant"),
              actions: [
                IconButton(
                  tooltip: "Delete Tenant",
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // context
                    //     .read<TenantBloc>()
                    //     .add(DeleteTenant(state.tenant.id));
                  },
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 16.0,
                              ),
                              child: Text(
                                state.tenant.name,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Text(
                              'Id  ${state.tenant.id}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Created At  ${state.tenant.createdAt}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Type  ${state.tenant.type}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Updated At  ${state.tenant.updatedAt}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Created By  ${state.tenant.createdBy}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: "Edit tenant",
              child: Icon(Icons.edit),
              onPressed: () {
                //context.read<TenantBloc>().add()
              },
            ),
          );
        }
      },
    );
  }
}
