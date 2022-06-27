part of 'mercaderiasabores_bloc.dart';

abstract class MercaderiaSaboresState extends Equatable {
  const MercaderiaSaboresState();

  @override
  List<Object?> get props => [];
}

class MercaderiaSaboresInitial extends MercaderiaSaboresState {}

class MercaderiaSaboresLoading extends MercaderiaSaboresState {}

class MercaderiaSaboresLoaded extends MercaderiaSaboresState {
  final List<MercaderiaSabor> mercaderiasabores;
  const MercaderiaSaboresLoaded(this.mercaderiasabores);
}

class MercaderiaSaboresError extends MercaderiaSaboresState {
  final String? message;
  const MercaderiaSaboresError(this.message);
}