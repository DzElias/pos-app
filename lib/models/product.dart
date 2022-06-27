
import 'dart:convert';

class Product {
    Product({
        required this.mercaderiaId,
        required this.codbar,
        required this.descripcion,
        required this.precio1,
        required this.sabor,
        required this.grupoId,
    });

    int mercaderiaId;
    String codbar;
    String descripcion;
    int precio1;
    int sabor;
    int grupoId;

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        mercaderiaId: json["MercaderiaId"],
        codbar: json["Codbar"],
        descripcion: json["Descripcion"],
        precio1: json["Precio1"],
        sabor: json["sabor"],
        grupoId: json["GrupoId"],
    );

    Map<String, dynamic> toJson() => {
        "MercaderiaId": mercaderiaId,
        "Codbar": codbar,
        "Descripcion": descripcion,
        "Precio1": precio1,
        "sabor": sabor,
        "GrupoId": grupoId,
    };
}
