import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shipanther/data/shipment/shipment_repository.dart';
import 'package:trober_sdk/api.dart';

part 'shipment_event.dart';
part 'shipment_state.dart';

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  final ShipmentRepository _shipmentRepository;
  ShipmentBloc(this._shipmentRepository) : super(ShipmentInitial()) {
    on<GetShipment>((event, emit) async {
      emit(ShipmentLoading());
      try {
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
          }
        }
        emit(ShipmentLoaded(shipment, downloadURL));
      } catch (e) {
        emit(ShipmentFailure('Request failed: $e'));
      }
    });
    on<GetShipments>((event, emit) async {
      emit(ShipmentLoading());
      try {
        final shipments = await _shipmentRepository.fetchShipments(
            shipmentStatus: event.shipmentStatus);
        emit(ShipmentsLoaded(shipments, event.shipmentStatus));
      } catch (e) {
        emit(ShipmentFailure('Request failed: $e'));
      }
    });
    on<UpdateShipment>((event, emit) async {
      emit(ShipmentLoading());
      try {
        await _shipmentRepository.updateShipment(event.id, event.shipment);
        final shipments = await _shipmentRepository.fetchShipments();
        emit(ShipmentsLoaded(shipments, null));
      } catch (e) {
        emit(ShipmentFailure('Request failed: $e'));
      }
    });
    on<CreateShipment>((event, emit) async {
      emit(ShipmentLoading());
      try {
        await _shipmentRepository.createShipment(event.shipment);
        final shipments = await _shipmentRepository.fetchShipments();
        emit(ShipmentsLoaded(shipments, null));
      } catch (e) {
        emit(ShipmentFailure('Request failed: $e'));
      }
    });
    on<DeleteShipment>((event, emit) async {
      emit(const ShipmentFailure('Shipment deletion is not supported'));
    });
  }
}
