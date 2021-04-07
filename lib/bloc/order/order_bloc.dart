import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/order/order_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this._orderRepository) : super(OrderInitial());
  final OrderRepository _orderRepository;

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    yield OrderLoading();
    try {
      if (event is GetOrder) {
        final order = await _orderRepository.fetchOrder(event.id);
        if (order == null) {
          throw 'order not found';
        }
        yield OrderLoaded(order);
      }
      if (event is GetOrders) {
        final orders =
            await _orderRepository.fetchOrders(orderStatus: event.orderStatus);
        yield OrdersLoaded(orders, event.orderStatus);
      }
      if (event is UpdateOrder) {
        await _orderRepository.updateOrder(event.id, event.order);
        final orders = await _orderRepository.fetchOrders();
        yield OrdersLoaded(orders, null);
      }
      if (event is CreateOrder) {
        await _orderRepository.createOrder(event.order);
        final orders = await _orderRepository.fetchOrders();
        yield OrdersLoaded(orders, null);
      }
      if (event is DeleteOrder) {
        yield const OrderFailure('Order deletion is not supported');
      }
    } catch (e) {
      yield OrderFailure('Request failed: $e');
    }
  }
}
