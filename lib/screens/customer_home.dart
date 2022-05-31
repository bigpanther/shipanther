import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/screens/order/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/trober_sdk.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome(this.user, {Key? key}) : super(key: key);
  final User user;

  @override
  CustomerHomeState createState() => CustomerHomeState();
}

class CustomerHomeState extends State<CustomerHome> {
  late OrderBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<OrderBloc>();
    bloc.add(const GetOrders());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
          title: ShipantherLocalizations.of(context).tenantsTitle(2),
          body: const CenteredLoading(),
        );
      },
    );
  }
}
