import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/tenant/list.dart';
import 'package:shipanther/widgets/loading_widget.dart';
import 'package:trober_sdk/api.dart';

class TenantScreen extends StatefulWidget {
  const TenantScreen(this.loggedInUser, {Key? key}) : super(key: key);

  final User loggedInUser;

  @override
  _TenantScreenState createState() => _TenantScreenState();
}

class _TenantScreenState extends State<TenantScreen> {
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
          return TenantList(widget.loggedInUser,
              tenantBloc: bloc, tenantLoadedState: state);
        }
        return LoadingWidget(
            loggedInUser: widget.loggedInUser,
            title: ShipantherLocalizations.of(context)!.tenantsTitle(2));
      },
    );
  }
}
