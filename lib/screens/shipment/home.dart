import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/shipment/shipment_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/shipment/add_edit.dart';
import 'package:shipanther/screens/shipment/driver_list.dart';
import 'package:shipanther/screens/shipment/list.dart';

import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;
import 'package:shipanther/extensions/user_extension.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen(this.loggedInUser);
  final api.User loggedInUser;
  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  ShipmentBloc bloc;
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
