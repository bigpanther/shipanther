import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/screens/tenant/detail.dart';
import 'package:shipanther/screens/tenant/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TenantBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<TenantBloc>();
    bloc.add(GetTenants(null));
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
        if (state is TenantsLoaded) {
          return TenantList(tenantBloc: bloc, tenantLoadedState: state);
        }
        if (state is TenantLoaded) {
          return TenantDetail(tenantBloc: bloc, state: state);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Tenants"),
          ),
          body: CenteredLoading(),
        );
      },
    );
  }
}
