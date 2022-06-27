import 'dart:convert';

class MercaderiaSabor {
    MercaderiaSabor({
        required this.mercaderiaSaborid,
        required this.mercaderiaId,
        required this.saborId
       
    });

    int mercaderiaSaborid;
    int mercaderiaId;
    int saborId;


    factory MercaderiaSabor.fromRawJson(String str) => MercaderiaSabor.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MercaderiaSabor.fromJson(Map<String, dynamic> json) => MercaderiaSabor(
        mercaderiaSaborid: json["MercaderiaSaborId"],
        mercaderiaId: json["MercaderiaId"],
        saborId: json["SaborId"],

        
    );

    Map<String, dynamic> toJson() => {
        "MercaderiaSaborid": mercaderiaSaborid,
        "MercaderiaId": mercaderiaId,
        "SaborId": saborId,
        
    };
}
