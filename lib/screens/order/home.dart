import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/order/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:trober_sdk/api.dart' as api;

class OrderScreen extends StatefulWidget {
  final api.User loggedInUser;

  const OrderScreen(this.loggedInUser, {Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<OrderBloc>();
    bloc.add(GetOrders(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => TerminalScreen()));
        }
      },
      builder: (context, state) {
        print(state);
        if (state is OrdersLoaded) {
          return OrderList(widget.loggedInUser,
              orderBloc: bloc, orderLoadedState: state);
        }
        if (state is OrderLoaded) {
          // return OrderDetail(orderBloc: bloc, state: state);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(ShipantherLocalizations.of(context).ordersTitle),
          ),
          body: CenteredLoading(),
        );
      },
    );
  }
}
