import 'dart:async';

import 'package:app_atractivos/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nombreController = BehaviorSubject<String>();
  final _apellidoController = BehaviorSubject<String>();
  final _edadController = BehaviorSubject<String>();
  final _paisController = BehaviorSubject<String>();
  final _ciudadController = BehaviorSubject<String>();

  //Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<String> get nombreStream => _passwordController.stream;
  Stream<String> get apellidoStream => _passwordController.stream;
  Stream<String> get edadStream => _passwordController.stream;
  Stream<String> get ciudadStream => _passwordController.stream;
  Stream<String> get paisStream => _passwordController.stream;

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);
  //Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeNombre => _nombreController.sink.add;
  Function(String) get changeApellido => _apellidoController.sink.add;
  Function(String) get changeEdad => _edadController.sink.add;
  Function(String) get changePais => _paisController.sink.add;
  Function(String) get changeCiudad => _ciudadController.sink.add;

  //Obtener el último valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get nombre => _nombreController.value;
  String get apellido => _apellidoController.value;
  String get edad => _edadController.value;
  String get ciudad => _ciudadController.value;
  String get pais => _paisController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _nombreController?.close();
    _apellidoController?.close();
    _edadController?.close();
    _paisController?.close();
    _ciudadController?.close();
  }
}
