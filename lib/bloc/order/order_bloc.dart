import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/order/order_repository.dart';
import 'package:trober_sdk/api.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;

  OrderBloc(this._orderRepository) : super(OrderInitial());

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    yield OrderLoading();
    try {
      if (event is GetOrder) {
        yield OrderLoaded(await _orderRepository.fetchOrder(event.id));
      }
      if (event is GetOrders) {
        var orders = await _orderRepository.filterOrders(event.orderStatus);
        yield OrdersLoaded(orders, event.orderStatus);
      }
      if (event is UpdateOrder) {
        await _orderRepository.updateOrder(event.id, event.order);
        var orders = await _orderRepository.filterOrders(null);
        yield OrdersLoaded(orders, null);
      }
      if (event is CreateOrder) {
        await _orderRepository.createOrder(event.order);
        var orders = await _orderRepository.filterOrders(null);
        yield OrdersLoaded(orders, null);
      }
      if (event is DeleteOrder) {
        yield OrderFailure("Order deletion is not supported");
      }
    } catch (e) {
      yield OrderFailure("Request failed: $e");
    }
  }
}
