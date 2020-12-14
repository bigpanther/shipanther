part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {
  const OrderEvent();
}

class GetOrder extends OrderEvent {
  const GetOrder(this.id);
  final String id;
}

class UpdateOrder extends OrderEvent {
  const UpdateOrder(this.id, this.order);
  final String id;
  final Order order;
}

class CreateOrder extends OrderEvent {
  const CreateOrder(this.order);
  final Order order;
}

class DeleteOrder extends OrderEvent {
  const DeleteOrder(this.id);
  final String id;
}

class GetOrders extends OrderEvent {
  const GetOrders(this.orderStatus);
  final OrderStatus orderStatus;
}
