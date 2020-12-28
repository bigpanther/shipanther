import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/carrier/carrier_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/carrier/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:trober_sdk/api.dart' as api;

class CarrierScreen extends StatefulWidget {
  const CarrierScreen(this.loggedInUser, {Key? key}) : super(key: key);
  final api.User loggedInUser;

  @override
  _CarrierScreenState createState() => _CarrierScreenState();
}

class _CarrierScreenState extends State<CarrierScreen> {
  late CarrierBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<CarrierBloc>();
    bloc.add(const GetCarriers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarrierBloc, CarrierState>(
      listener: (context, state) {
        if (state is CarrierFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is CarriersLoaded) {
          return CarrierList(widget.loggedInUser,
              carrierBloc: bloc, carrierLoadedState: state);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(ShipantherLocalizations.of(context).carriersTitle(2)),
          ),
          body: const CenteredLoading(),
        );
      },
    );
  }
}
