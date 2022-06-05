import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:shipanther/screens/order/list.dart';
import 'package:shipanther/widgets/loading_widget.dart';
import 'package:trober_sdk/trober_sdk.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen(this.loggedInUser, {Key? key}) : super(key: key);
  final User loggedInUser;

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
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
        if (state is OrderLoaded) {
          context.pushRoute(
            OrderAddEdit(
              loggedInUser: widget.loggedInUser,
              isEdit: true,
              orderBloc: bloc,
              order: state.order,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is OrdersLoaded) {
          return OrderList(widget.loggedInUser,
              orderBloc: bloc, orderLoadedState: state);
        }
        return LoadingWidget(
            loggedInUser: widget.loggedInUser,
            title: ShipantherLocalizations.of(context).ordersTitle(2));
      },
    );
  }
}
