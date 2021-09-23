import 'package:flutter/material.dart';
import 'package:ingreso/src/models/tipoIngreso.dart';
import 'package:http/http.dart' as http;
import 'package:ingreso/src/util/app_url.dart';

class TipoIngresoService with ChangeNotifier {
  List<TipoIngreso> headlines = [];
  TipoIngresoService() {
    this.getTopHeadlines();
  }
  getTopHeadlines() async {
    final url = Uri.parse('${AppUrl.baseURL}/api/TipoIngreso');

    final resp = await http.get(url);

    final newsResponse = tipoIngresoFromMap(resp.body);
    this.headlines.addAll(newsResponse);

    notifyListeners();
  }
}
