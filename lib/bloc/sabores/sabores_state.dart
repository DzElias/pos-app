part of 'sabores_bloc.dart';

abstract class SaboresState extends Equatable {
  const SaboresState();

  @override
  List<Object?> get props => [];
}

class SaboresInitial extends SaboresState {}

class SaboresLoading extends SaboresState {}

class SaboresLoaded extends SaboresState {
  final List<Sabor> sabores;
  const SaboresLoaded(this.sabores);
}

class SaboresError extends SaboresState {
  final String? message;
  const SaboresError(this.message);
}