import 'dart:async';
import 'package:flutter_app_hotel_management/data/repositories/auth_repository.dart';
import 'package:flutter_app_hotel_management/utils/api_response.dart';
import 'package:flutter_app_hotel_management/utils/validation.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel {
  final _usernameController = StreamController<String>();
  final _passwordController = StreamController<String>();
  final _btnLoginController = StreamController<bool>();
  final _loginResultController = StreamController<ApiResponseAuth>();
  final AuthRepository _authRepository = AuthRepository();

  Stream<String> get usernameStream => _usernameController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<bool> get btnLoginStream => _btnLoginController.stream;
  Stream<ApiResponseAuth> get loginResultStream =>
      _loginResultController.stream;

  LoginBloc() {
    Rx.combineLatest2(_usernameController.stream, _passwordController.stream,
        (username, password) {
      return Validation.validateUsername(username) == '' &&
          Validation.validatePassword(password) == '';
    }).listen((enable) {
      _btnLoginController.add(enable);
    });
  }

  void loginUser(String username, String password) async {
    ApiResponseAuth loginResult =
        await _authRepository.loginUser(username, password);
    _loginResultController.add(loginResult);
  }

  void dispose() {
    _usernameController.close();
    _passwordController.close();
    _btnLoginController.close();
    _loginResultController.close();
  }

  void setUsername(String username) {
    _usernameController.add(username);
  }

  void setPassword(String password) {
    _passwordController.add(password);
  }
}
