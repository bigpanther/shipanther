import 'package:flutter/material.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/tenant/add_edit.dart';

class TenantDetail extends StatelessWidget {
  const TenantDetail({Key? key, required this.state, required this.tenantBloc})
      : super(key: key);

  final TenantLoaded state;
  final TenantBloc tenantBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ShipantherLocalizations.of(context)!.tenantDetail),
        actions: [
          IconButton(
            tooltip: ShipantherLocalizations.of(context)!.tenantDelete,
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
                      displaySubtitle(
                          ShipantherLocalizations.of(context)!.tenantId,
                          state.tenant.id),
                      displaySubtitle(
                          ShipantherLocalizations.of(context)!.tenantType,
                          state.tenant.type.toString()),
                      displaySubtitle(
                          ShipantherLocalizations.of(context)!.createdAt,
                          state.tenant.createdAt,
                          formatter: ShipantherLocalizations.of(context)!
                              .dateFormatter),
                      displaySubtitle(
                          ShipantherLocalizations.of(context)!.lastUpdate,
                          state.tenant.updatedAt,
                          formatter: ShipantherLocalizations.of(context)!
                              .dateFormatter),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: ShipantherLocalizations.of(context)!.tenantEdit,
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
