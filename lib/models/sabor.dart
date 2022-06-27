import 'dart:convert';

class Sabor {
    Sabor({
        required this.saborid,
        required this.sabor,
       
    });

    int saborid;
    String sabor;


    factory Sabor.fromRawJson(String str) => Sabor.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sabor.fromJson(Map<String, dynamic> json) => Sabor(
        saborid: json["saborid"],
        sabor: json["sabor"],
        
    );

    Map<String, dynamic> toJson() => {
        "saborid": saborid,
        "sabor": sabor,
        
    };
}
