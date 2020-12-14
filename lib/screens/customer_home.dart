import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/order/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome(this.user, {Key key}) : super(key: key);
  final User user;

  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  OrderBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<OrderBloc>();
    bloc.add(const GetOrders(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is OrdersLoaded) {
          return OrderList(widget.user,
              orderBloc: bloc, orderLoadedState: state);
        }
        return ShipantherScaffold(
          widget.user,
          title: ShipantherLocalizations.of(context).tenantsTitle,
          actions: const [],
          body: const CenteredLoading(),
          floatingActionButton: null,
          bottomNavigationBar: null,
        );
      },
    );
  }
}
