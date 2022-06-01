part of 'order_bloc.dart';

@immutable
abstract class OrderState {
  const OrderState();
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  const OrderLoaded(this.order);
  final api.Order order;
}

class OrdersLoaded extends OrderState {
  const OrdersLoaded(this.orders, this.orderStatus);
  final List<api.Order> orders;
  final api.OrderStatus? orderStatus;
}

class OrderFailure extends OrderState {
  const OrderFailure(this.message);
  final String message;
}
