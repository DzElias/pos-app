part of 'mercaderiasabores_bloc.dart';

abstract class MercaderiaSaboresEvent extends Equatable {
  const MercaderiaSaboresEvent();

  @override
  List<Object> get props => [];
}

class GetMercaderiaSaboresList extends MercaderiaSaboresEvent {}