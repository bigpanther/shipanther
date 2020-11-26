import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/carrier/carrier_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/carrier/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:trober_sdk/api.dart' as api;

class CarrierScreen extends StatefulWidget {
  final api.User loggedInUser;

  const CarrierScreen(this.loggedInUser, {Key key}) : super(key: key);

  @override
  _CarrierScreenState createState() => _CarrierScreenState();
}

class _CarrierScreenState extends State<CarrierScreen> {
  CarrierBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<CarrierBloc>();
    bloc.add(GetCarriers(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarrierBloc, CarrierState>(
      listener: (context, state) {
        if (state is CarrierFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => CarrierScreen()));
        }
      },
      builder: (context, state) {
        if (state is CarriersLoaded) {
          return CarrierList(widget.loggedInUser,
              carrierBloc: bloc, carrierLoadedState: state);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(ShipantherLocalizations.of(context).carriersTitle),
          ),
          body: CenteredLoading(),
        );
      },
    );
  }
}
