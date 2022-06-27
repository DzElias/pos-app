import 'dart:convert';

import 'package:pos_app/models/sabor.dart';

class Order {
    Order({
        required this.subTotal,
        required this.mercaderiaId,
        required this.cantidad,
        required this.descripcion,
        required this.sabores,
    });

    int mercaderiaId;
    int subTotal;
    int cantidad;
    String descripcion;
    List<Sabor> sabores;

    String toRawJson() => json.encode(toJson());

    Map<String, dynamic> toJson() => {
        "MercaderiaId": "$mercaderiaId",
        "SubTotal": "$subTotal",
        "Cantidad": "$cantidad",
        "sabores": List<dynamic>.from(sabores.map((x) => x)),
    };
}
