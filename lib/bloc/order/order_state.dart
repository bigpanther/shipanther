part of 'order_bloc.dart';

@immutable
abstract class OrderState {
  const OrderState();
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final Order order;
  const OrderLoaded(this.order);
}

class OrdersLoaded extends OrderState {
  final List<Order> orders;

  const OrdersLoaded(this.orders);
}

class OrderFailure extends OrderState {
  final String message;
  const OrderFailure(this.message);
}
