import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ingreso/src/models/ingreso.dart';
import 'dart:convert';

import 'package:ingreso/src/util/app_url.dart';

import 'auth_service.dart';

class IngresarService with ChangeNotifier {
  List<Ingreso> headlines = [];

  IngresarService() {
    this.getTopHeadlines();
  }

  Future<String?> crearIngreso(
    int tipoFormularioId,
    String martricula,
    String empresa,
    String pasajero,
    String cedula,
    String calle,
    String numero,
    String observacion,
    String ingresoSwitch,
  ) async {
    final params = {
      "tipoIngresoId": tipoFormularioId,
      "entidad": empresa,
      "placa": martricula,
      "nombreCompleto": "",
      "cedula": cedula,
      "pasajero": pasajero,
      "calle": calle,
      "numero": numero,
      "evento": 0,
      "observacion": observacion
    };

    final url = Uri.parse('${AppUrl.baseURL}/api/Ingreso');
    final auth = new AuthService();
    String key = await auth.readToken();
    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $key',
      },
      body: json.encode(params),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp.containsKey('id')) {
      return null;
    } else {
      return decodedResp['message'];
    }
  }

  getTopHeadlines() async {
    final auth = new AuthService();
    String key = await auth.readToken();

    final url = Uri.parse('${AppUrl.baseURL}/api/Ingreso');
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $key',
    });
    final response = ingresoFromMap(resp.body);
    this.headlines.addAll(response);
    notifyListeners();
  }
}
