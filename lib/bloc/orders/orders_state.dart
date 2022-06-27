part of 'orders_bloc.dart';


class OrdersState extends Equatable{

   final List<Order> orders;

  const OrdersState({
    this.orders = const []
  });

  OrdersState copyWith({

    List<Order>? orders

  }) => OrdersState(
    orders: orders ?? this.orders
  );

  @override
  List<Object> get props => [orders];
}

class OrderRemoved extends OrdersState {}

