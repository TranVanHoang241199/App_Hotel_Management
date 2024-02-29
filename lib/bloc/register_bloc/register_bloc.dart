import 'dart:async';
import 'package:flutter_app_hotel_management/data/models/user_model.dart';
import 'package:flutter_app_hotel_management/data/repositories/auth_repositories.dart';
import 'package:flutter_app_hotel_management/utils/api_response.dart';
import 'package:flutter_app_hotel_management/utils/validation.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloC {
  final _usernameSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _fullNameSubject = BehaviorSubject<String>();
  final _phoneSubject = BehaviorSubject<String>();
  final _emailSubject = BehaviorSubject<String>();
  final _selectedRole = BehaviorSubject<String>();
  final _btnRegisterSubject = BehaviorSubject<bool>();

  var usernameValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    sink.add(Validation.validateUsername(username));
  });

  var passValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    sink.add(Validation.validatePassword(pass));
  });

  var fullNameValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (fullName, sink) {
    sink.add(Validation.validatePassword(fullName));
  });

  var phoneValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    sink.add(Validation.validatePassword(phone));
  });

  var emailValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    sink.add(Validation.validatePassword(email));
  });

  var roleValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    sink.add(Validation.validatePassword(email));
  });

  Stream<String> get usernameStream =>
      _usernameSubject.stream.transform(usernameValidation);
  Sink<String> get usernameSink => _usernameSubject.sink;

  Stream<String> get passStream =>
      _passSubject.stream.transform(passValidation);
  Sink<String> get passSink => _passSubject.sink;

  Stream<bool> get btnRegisterStream => _btnRegisterSubject.stream;
  Sink<bool> get btnRegisterSink => _btnRegisterSubject.sink;

  RegisterBloC() {
    Rx.combineLatest2(_usernameSubject, _passSubject, (username, pass) {
      return Validation.validateUsername(username) == '' &&
          Validation.validatePassword(pass) == '';
    }).listen((enable) {
      btnRegisterSink.add(enable);
    });
  }

  Future<ApiResponse<UserModel>> registerUser(UserModel model) async {
    // Sử dụng hàm từ ApiHelper
    return await AuthRepositories.registerUser(model);
  }

  void dispose() {
    _usernameSubject.close();
    _passSubject.close();
    _fullNameSubject.close();
    _phoneSubject.close();
    _emailSubject.close();
    _btnRegisterSubject.close();
    _selectedRole.close();
  }
}
