import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pos_app/models/mercaderiaSabor.dart';
import 'package:pos_app/services/api_repository.dart';

part 'mercaderiasabores_event.dart';
part 'mercaderiasabores_state.dart';

class MercaderiasaboresBloc extends Bloc<MercaderiaSaboresEvent, MercaderiaSaboresState> {
  MercaderiasaboresBloc() : super(MercaderiaSaboresInitial()) {
     final ApiRepository _apiRepository = ApiRepository();

    on<GetMercaderiaSaboresList>((event, emit) async {
      try {
        emit(MercaderiaSaboresLoading());
        final mList = await _apiRepository.fetchMercaderiaSabor();
        emit(MercaderiaSaboresLoaded(mList));
      } on NetworkError {
        emit(const MercaderiaSaboresError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
