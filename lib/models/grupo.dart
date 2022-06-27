
import 'dart:convert';

class Grupo {
    Grupo({
        required this.grupoId,
        required this.grupo,
        required this.produccion,
        required this.visible,
        required this.sectorProduccionid,
    });

    int grupoId;
    String grupo;
    String produccion;
    String visible;
    int sectorProduccionid;

    factory Grupo.fromRawJson(String str) => Grupo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        grupoId: json["GrupoId"],
        grupo: json["grupo"],
        produccion: json["Produccion"],
        visible: json["visible"],
        sectorProduccionid: json["SectorProduccionid"],
    );

    Map<String, dynamic> toJson() => {
        "GrupoId": grupoId,
        "grupo": grupo,
        "Produccion": produccion,
        "visible": visible,
        "SectorProduccionid": sectorProduccionid,
    };
}
