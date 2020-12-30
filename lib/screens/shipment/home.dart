import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/shipment/shipment_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/shipment/add_edit.dart';
import 'package:shipanther/screens/shipment/driver_list.dart';
import 'package:shipanther/screens/shipment/list.dart';
import 'package:shipanther/widgets/loading_widget.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/user_extension.dart';

class ShipmentScreen extends StatefulWidget {
  const ShipmentScreen(this.loggedInUser);
  final User loggedInUser;
  @override
  _ShipmentScreenState createState() => _ShipmentScreenState();
}

class _ShipmentScreenState extends State<ShipmentScreen> {
  late ShipmentBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<ShipmentBloc>();
    bloc.add(const GetShipments());
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
        if (state is ShipmentLoaded) {
          Navigator.of(context).push(
            MaterialPageRoute<Widget>(
              builder: (_) => ShipmentAddEdit(
                widget.loggedInUser,
                isEdit: true,
                shipmentBloc: bloc,
                shipment: state.shipment,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ShipmentsLoaded) {
          return widget.loggedInUser.isDriver
              ? DriverShipmentList(widget.loggedInUser,
                  shipmentBloc: bloc, shipmentsLoadedState: state)
              : ShipmentList(widget.loggedInUser,
                  shipmentBloc: bloc, shipmentsLoadedState: state);
        }
        return LoadingWidget(
            loggedInUser: widget.loggedInUser,
            title: ShipantherLocalizations.of(context)!.shipmentsTitle(2));
      },
    );
  }
}
