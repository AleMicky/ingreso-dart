// To parse this JSON data, do
//
//     final ingreso = ingresoFromMap(jsonString);

import 'dart:convert';

List<Ingreso> ingresoFromMap(String str) =>
    List<Ingreso>.from(json.decode(str).map((x) => Ingreso.fromMap(x)));

String ingresoToMap(List<Ingreso> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Ingreso {
  int? id;
  String? tipo;
  String? empresa;
  String? placa;
  String? nombreCompleto;
  String? cedula;
  String? pasajero;
  String? calle;
  String? numero;
  String? observacion;
  DateTime fecha;
  String? evento;

  Ingreso({
    this.id,
    this.tipo,
    this.empresa,
    this.placa,
    this.nombreCompleto,
    this.cedula,
    this.pasajero,
    this.calle,
    this.numero,
    this.observacion,
    required this.fecha,
    this.evento,
  });

  Ingreso copyWith({
    int? id,
    String? tipo,
    String? empresa,
    String? placa,
    String? nombreCompleto,
    String? cedula,
    String? pasajero,
    String? calle,
    String? numero,
    String? observacion,
    DateTime? fecha,
    String? evento,
  }) =>
      Ingreso(
        id: id ?? this.id,
        tipo: tipo ?? this.tipo,
        empresa: empresa ?? this.empresa,
        placa: placa ?? this.placa,
        nombreCompleto: nombreCompleto ?? this.nombreCompleto,
        cedula: cedula ?? this.cedula,
        pasajero: pasajero ?? this.pasajero,
        calle: calle ?? this.calle,
        numero: numero ?? this.numero,
        observacion: observacion ?? this.observacion,
        fecha: fecha ?? this.fecha,
        evento: evento ?? this.evento,
      );

  factory Ingreso.fromMap(Map<String, dynamic> json) => Ingreso(
        id: json["id"],
        tipo: json["tipo"],
        empresa: json["empresa"],
        placa: json["placa"],
        nombreCompleto: json["nombreCompleto"],
        cedula: json["cedula"],
        pasajero: json["pasajero"],
        calle: json["calle"],
        numero: json["numero"],
        observacion: json["observacion"],
        fecha: DateTime.parse(json["fecha"]),
        evento: json["evento"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tipo": tipo,
        "empresa": empresa,
        "placa": placa,
        "nombreCompleto": nombreCompleto,
        "cedula": cedula,
        "pasajero": pasajero,
        "calle": calle,
        "numero": numero,
        "observacion": observacion,
        "fecha": fecha.toIso8601String(),
        "evento": evento,
      };
}
