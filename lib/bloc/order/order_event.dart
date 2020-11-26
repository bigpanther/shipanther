part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {
  const OrderEvent();
}

class GetOrder extends OrderEvent {
  final String id;
  const GetOrder(this.id);
}

class UpdateOrder extends OrderEvent {
  final String id;
  final Order order;
  const UpdateOrder(this.id, this.order);
}

class CreateOrder extends OrderEvent {
  final Order order;
  const CreateOrder(this.order);
}

class DeleteOrder extends OrderEvent {
  final String id;
  const DeleteOrder(this.id);
}

class GetOrders extends OrderEvent {
  final OrderStatus orderStatus;
  const GetOrders(this.orderStatus);
}
