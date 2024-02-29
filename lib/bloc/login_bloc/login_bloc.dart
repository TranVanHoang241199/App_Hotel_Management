import 'dart:async';
import 'package:flutter_app_hotel_management/data/repositories/auth_repositories.dart';
import 'package:flutter_app_hotel_management/utils/api_response.dart';
import 'package:flutter_app_hotel_management/utils/validation.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloC {
  final _usernameSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _btnLoginSubject = BehaviorSubject<bool>();

  var usernameValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    sink.add(Validation.validateUsername(username));
  });

  var passValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    sink.add(Validation.validatePassword(pass));
  });

  Stream<String> get usernameStream =>
      _usernameSubject.stream.transform(usernameValidation);
  Sink<String> get usernameSink => _usernameSubject.sink;

  Stream<String> get passStream =>
      _passSubject.stream.transform(passValidation);
  Sink<String> get passSink => _passSubject.sink;

  Stream<bool> get btnLoginStream => _btnLoginSubject.stream;
  Sink<bool> get btnLoginSink => _btnLoginSubject.sink;

  LoginBloC() {
    Rx.combineLatest2(_usernameSubject, _passSubject, (username, pass) {
      return Validation.validateUsername(username) == '' &&
          Validation.validatePassword(pass) == '';
    }).listen((enable) {
      btnLoginSink.add(enable);
    });
  }

  Future<ApiResponseAuth> signUserIn(String username, String password) async {
    // Sử dụng hàm từ ApiHelper
    return await AuthRepositories.loginUser(username, password);
  }

  void dispose() {
    _usernameSubject.close();
    _passSubject.close();
    _btnLoginSubject.close();
  }
}
