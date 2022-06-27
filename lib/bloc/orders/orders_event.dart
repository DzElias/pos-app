part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OnAddOrderToCart extends OrdersEvent {
  final Order order;
  const OnAddOrderToCart(this.order);
}

class OnRemoveOrder extends OrdersEvent{
  final int mercaderiaId;
  const OnRemoveOrder(this.mercaderiaId); 
}

class OnSubAmount extends OrdersEvent {
  final int mercaderiaId;
  const OnSubAmount(this.mercaderiaId);
}

class OnAddAmount extends OrdersEvent {
  final int mercaderiaId;
  const OnAddAmount(this.mercaderiaId);
}


