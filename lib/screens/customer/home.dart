import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/customer/customer_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/customer/list.dart';
import 'package:shipanther/widgets/loading_widget.dart';
import 'package:trober_sdk/api.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome(this.loggedInUser, {Key? key}) : super(key: key);
  final User loggedInUser;

  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  late CustomerBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<CustomerBloc>();
    bloc.add(const GetCustomers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if (state is CustomerFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is CustomersLoaded) {
          return CustomerList(widget.loggedInUser,
              customerBloc: bloc, customerLoadedState: state);
        }
        return LoadingWidget(
            loggedInUser: widget.loggedInUser,
            title: ShipantherLocalizations.of(context)!.customersTitle(2));
      },
    );
  }
}
