import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_app/models/grupo.dart';
import 'package:pos_app/services/api_repository.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  GroupsBloc() : super(GroupInitial()) {
   final ApiRepository _apiRepository = ApiRepository();

    on<GetGroupsList>((event, emit) async {
      try {
        emit(GroupLoading());
        final mList = await _apiRepository.fetchGroupList();
        emit(GroupLoaded(mList));
      } on NetworkError {
        emit(GroupError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
