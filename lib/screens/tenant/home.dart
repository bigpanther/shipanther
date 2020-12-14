import 'package:flutter/material.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/screens/tenant/add_edit.dart';

class TenantDetail extends StatelessWidget {
  const TenantDetail({Key key, this.state, this.tenantBloc}) : super(key: key);

  final TenantLoaded state;
  final TenantBloc tenantBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenant Details'),
        actions: [
          IconButton(
            tooltip: 'Delete Tenant',
            icon: const Icon(Icons.delete),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                        padding: const EdgeInsets.only(
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Edit tenant',
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (_) => TenantAddEdit(
                isEdit: true,
                tenantBloc: tenantBloc,
                tenant: state.tenant,
              ),
            ),
          );
        },
      ),
    );
  }
}
