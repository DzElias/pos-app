part of 'groups_bloc.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object?> get props => [];
}

class GroupInitial extends GroupsState {}

class GroupLoading extends GroupsState {}

class GroupLoaded extends GroupsState {
  final List<Grupo> groups;
  const GroupLoaded(this.groups);
}

class GroupError extends GroupsState {
  final String? message;
  const GroupError(this.message);
}