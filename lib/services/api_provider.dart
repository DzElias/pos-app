import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pos_app/models/grupo.dart';
import 'package:pos_app/models/mercaderiaSabor.dart';
import 'package:pos_app/models/product.dart';
import 'package:pos_app/models/sabor.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'http://192.168.140.86:3000';

  Future<List<Grupo>> fetchGroupList() async {
    List<Grupo> grupos = [];
    
    try {
      Response response = await _dio.get("$_url/grupos");

      for(var singleGroup in response.data["data"]){
        Grupo grupo = Grupo.fromJson(singleGroup);
        if(grupo.visible == "S")
        {
          grupos.add(grupo);
        }
      }

      return grupos;
      
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return grupos;
    }
  }

  Future<List<Product>> fetchProductList() async {
    List<Product> products = [];

    try{
      Response response = await _dio.get("$_url/mercaderias");

      for(var singleProduct in response.data["data"]){
        Product producto = Product.fromJson(singleProduct);
        products.add(producto);
      }

      return products;
      
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return products;
    }
  }

  dynamic postOrders(orders) async {
    var response = await _dio.post('$_url/crear-venta', data: orders);
    return response;
  }

  Future<List<Sabor>> fetchSabores() async {
    List<Sabor> sabores = [];

    try{
      Response response = await _dio.get("$_url/sabor");

      for(var singleSabor in response.data["data"]){
        Sabor sabor = Sabor.fromJson(singleSabor);
        sabores.add(sabor);
      }

      return sabores;
      
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return sabores;
    }
  }

  Future<List<MercaderiaSabor>> fetchMercaderiaSabor() async {
    List<MercaderiaSabor> mercaderiaSabores = [];

    try{
      Response response = await _dio.get("$_url/mercaderiasabor");

      for(var singleMercaderiaSabor in response.data["data"]){
        MercaderiaSabor mercaderiaSabor = MercaderiaSabor.fromJson(singleMercaderiaSabor);
        mercaderiaSabores.add(mercaderiaSabor);
      }

      return mercaderiaSabores;
      
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return mercaderiaSabores;
    }
  }
 


}