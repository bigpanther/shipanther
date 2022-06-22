import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/order/order_repository.dart';
import 'package:trober_sdk/trober_sdk.dart' as api;
import 'package:dio/dio.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;
  OrderBloc(this._orderRepository) : super(OrderInitial()) {
    on<GetOrder>((event, emit) async {
      try {
        emit(OrderLoading());
        emit(OrderLoaded(await _orderRepository.fetchOrder(event.id)));
      } on DioError catch (e) {
        emit(OrderFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(OrderFailure('Request failed: $e'));
      }
    });

    on<GetOrders>((event, emit) async {
      try {
        emit(OrderLoading());
        final orders =
            await _orderRepository.fetchOrders(orderStatus: event.orderStatus);
        emit(OrdersLoaded(orders, event.orderStatus));
      } on DioError catch (e) {
        emit(OrderFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(OrderFailure('Request failed: $e'));
      }
    });

    on<UpdateOrder>((event, emit) async {
      try {
        emit(OrderLoading());
        await _orderRepository.updateOrder(event.id, event.order);
        final orders = await _orderRepository.fetchOrders();
        emit(OrdersLoaded(orders, null));
      } on DioError catch (e) {
        emit(OrderFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(OrderFailure('Request failed: $e'));
      }
    });
    on<SearchOrder>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders =
            await _orderRepository.fetchOrders(serialNumber: event.name);
        if (orders.isNotEmpty) {
          emit(OrdersLoaded(orders, null));
        } else {
          emit(OrderNotFound());
        }
      } on DioError catch (e) {
        emit(OrderFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(OrderFailure('Request failed: $e'));
      }
    });
    on<CreateOrder>((event, emit) async {
      try {
        emit(OrderLoading());
        await _orderRepository.createOrder(event.order);
        final orders = await _orderRepository.fetchOrders();
        emit(OrdersLoaded(orders, null));
      } on DioError catch (e) {
        emit(OrderFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(OrderFailure('Request failed: $e'));
      }
    });

    on<DeleteOrder>((event, emit) async {
      emit(const OrderFailure('Order deletion is not supported'));
    });
  }
}
