import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_app/models/sabor.dart';
import 'package:pos_app/services/api_repository.dart';

part 'sabores_event.dart';
part 'sabores_state.dart';

class SaboresBloc extends Bloc<SaboresEvent, SaboresState> {
  SaboresBloc() : super(SaboresInitial()) {
     final ApiRepository _apiRepository = ApiRepository();

    on<GetSaboresList>((event, emit) async {
      try {
        emit(SaboresLoading());
        final mList = await _apiRepository.fetchSabores();
        emit(SaboresLoaded(mList));
      } on NetworkError {
        emit(const SaboresError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
