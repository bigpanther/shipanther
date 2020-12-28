import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/shipment/shipment_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/shipment/driver_list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class DriverHome extends StatefulWidget {
  const DriverHome(this.loggedInUser, {Key? key}) : super(key: key);
  final User loggedInUser;

  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  late ShipmentBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<ShipmentBloc>();
    bloc.add(const GetShipments(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShipmentBloc, ShipmentState>(
      listener: (context, state) {
        if (state is ShipmentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is ShipmentsLoaded) {
          return DriverShipmentList(
            widget.loggedInUser,
            shipmentsLoadedState: state,
            shipmentBloc: bloc,
          );
        }
        return ShipantherScaffold(
          widget.loggedInUser,
          bottomNavigationBar: null,
          title: ShipantherLocalizations.of(context).shipmentsTitle(2),
          actions: const [],
          body: const CenteredLoading(),
          floatingActionButton: null,
        );
      },
    );
  }
}
