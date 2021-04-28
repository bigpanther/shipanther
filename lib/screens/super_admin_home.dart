import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/screens/tenant/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class SuperAdminHome extends StatefulWidget {
  const SuperAdminHome(this.user, {Key? key}) : super(key: key);
  final User user;

  @override
  _SuperAdminHomeState createState() => _SuperAdminHomeState();
}

class _SuperAdminHomeState extends State<SuperAdminHome> {
  late TenantBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<TenantBloc>();
    bloc.add(const GetTenants());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TenantBloc, TenantState>(
      listener: (context, state) {
        if (state is TenantFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is TenantsLoaded) {
          return TenantList(widget.user,
              tenantBloc: bloc, tenantLoadedState: state);
        }
        return ShipantherScaffold(
          widget.user,
          title: ShipantherLocalizations.of(context).tenantsTitle(2),
          body: const CenteredLoading(),
        );
      },
    );
  }
}
