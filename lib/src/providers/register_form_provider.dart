import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String nombre = '';
  String apellido = '';
  String edad = '';
  String pais = '';
  String ciudad = '';
  String email = '';
  String password = '';
  String rol = '';
  String sitioPreferido = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    print('$email - $password, $sitioPreferido');

    return formKey.currentState?.validate() ?? false;
  }
}
