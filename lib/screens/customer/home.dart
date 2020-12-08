import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/customer/customer_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/customer/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;

class CustomerHome extends StatefulWidget {
  final api.User loggedInUser;

  const CustomerHome(this.loggedInUser, {Key key}) : super(key: key);

  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  CustomerBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<CustomerBloc>();
    bloc.add(GetCustomers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if (state is CustomerFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is CustomersLoaded) {
          return CustomerList(widget.loggedInUser,
              customerBloc: bloc, customerLoadedState: state);
        }
        return ShipantherScaffold(
          widget.loggedInUser,
          title: ShipantherLocalizations.of(context).customersTitle,
          actions: [],
          body: CenteredLoading(),
          floatingActionButton: null,
        );
      },
    );
  }
}
