import 'package:pos_app/models/grupo.dart';
import 'package:pos_app/models/mercaderiaSabor.dart';
import 'package:pos_app/models/product.dart';
import 'package:pos_app/models/sabor.dart';
import 'package:pos_app/services/api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<Grupo>> fetchGroupList() {
    return _provider.fetchGroupList();
  }

  Future<List<Product>> fetchProductsList() {
    return _provider.fetchProductList();
  }

  Future<dynamic> postOrders(orders){
    return _provider.postOrders(orders);
  }

  Future<List<Sabor>> fetchSabores() {
    return _provider.fetchSabores();
  }

  Future<List<MercaderiaSabor>> fetchMercaderiaSabor(){
    return _provider.fetchMercaderiaSabor();
  }




}

class NetworkError extends Error {}