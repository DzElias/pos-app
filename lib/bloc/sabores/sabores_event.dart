part of 'sabores_bloc.dart';

abstract class SaboresEvent extends Equatable {
  const SaboresEvent();

  @override
  List<Object> get props => [];
}

class GetSaboresList extends SaboresEvent {}