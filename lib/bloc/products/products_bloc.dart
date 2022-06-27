import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_app/models/product.dart';
import 'package:pos_app/services/api_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
     final ApiRepository _apiRepository = ApiRepository();

    on<GetProductsList>((event, emit) async {
      try {
        emit(ProductsLoading());
        final mList = await _apiRepository.fetchProductsList();
        emit(ProductsLoaded(mList));
      } on NetworkError {
        emit(const ProductsError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
