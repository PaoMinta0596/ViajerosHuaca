import 'package:app_atractivos/src/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
export 'package:app_atractivos/src/bloc/login_bloc.dart';

class ProviderUs extends InheritedWidget {
  static ProviderUs _instancia;

  factory ProviderUs({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderUs._internal(key: key, child: child);
    }

    return _instancia;
  }

  ProviderUs._internal({Key key, Widget child}) : super(key: key, child: child);

  final loginBloc = LoginBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderUs>().loginBloc;
  }
}
