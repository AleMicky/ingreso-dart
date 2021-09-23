import 'package:flutter/material.dart';

class SearchFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String _cedula = '';
  String _matricula = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String get cedula => _cedula;
  String get matricula => _matricula;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set cedula(String value) {
    _cedula = value;
    notifyListeners();
  }

  set matricula(String value) {
    _matricula = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
