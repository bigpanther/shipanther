import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/shipment/shipment_repository.dart';
import 'package:trober_sdk/api.dart';

part 'shipment_event.dart';
part 'shipment_state.dart';

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  ShipmentBloc(this._shipmentRepository) : super(ShipmentInitial());
  final ShipmentRepository _shipmentRepository;

  @override
  Stream<ShipmentState> mapEventToState(
    ShipmentEvent event,
  ) async* {
    yield ShipmentLoading();
    try {
      if (event is GetShipment) {
        final shipment = await _shipmentRepository.fetchShipment(event.id);
        String? downloadURL;
        try {
          downloadURL = await FirebaseStorage.instance
              .ref()
              .child('files/${shipment.tenantId}/${shipment.customerId}')
              .child('/${shipment.id}.jpg')
              .getDownloadURL();
        } catch (e) {
          if (!kIsWeb) {
            await FirebaseCrashlytics.instance.recordError(e, null);
          } else {
            print(e);
          }
        }
        yield ShipmentLoaded(shipment, downloadURL);
      }
      if (event is GetShipments) {
        final shipments = await _shipmentRepository.fetchShipments(
            shipmentStatus: event.shipmentStatus);
        yield ShipmentsLoaded(shipments, event.shipmentStatus);
      }
      if (event is UpdateShipment) {
        await _shipmentRepository.updateShipment(event.id, event.shipment);
        final shipments = await _shipmentRepository.fetchShipments();
        yield ShipmentsLoaded(shipments, null);
      }
      if (event is CreateShipment) {
        await _shipmentRepository.createShipment(event.shipment);
        final shipments = await _shipmentRepository.fetchShipments();
        yield ShipmentsLoaded(shipments, null);
      }
      if (event is DeleteShipment) {
        yield const ShipmentFailure('Shipment deletion is not supported');
      }
    } catch (e) {
      yield ShipmentFailure('Request failed: $e');
    }
  }
}
