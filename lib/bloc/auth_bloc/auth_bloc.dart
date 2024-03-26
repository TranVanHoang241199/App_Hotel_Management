import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositorys/auth_repository.dart';
import '../../utils/utils.dart';
import '../auth_bloc/auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;

  final _loginUsernameSubject = BehaviorSubject<String>();
  final _loginpassSubject = BehaviorSubject<String>();
  final _btnLoginSubject = BehaviorSubject<bool>();

  final _registerUsernameSubject = BehaviorSubject<String>();
  final _registerPassSubject = BehaviorSubject<String>();
  final _registerFullNameSubject = BehaviorSubject<String>();
  final _registerPhoneSubject = BehaviorSubject<String>();
  final _registerEmailSubject = BehaviorSubject<String>();
  final _btnRegisterSubject = BehaviorSubject<bool>();

  AuthBloc(AuthState initialState, this._repo) : super(AuthInitState()) {
    // login check
    Rx.combineLatest2(_loginUsernameSubject, _loginpassSubject,
        (username, pass) {
      return username.isNotEmpty &&
          pass.isNotEmpty &&
          Validation.validateUsername(username) == '' &&
          Validation.validatePassword(pass) == '';
    }).listen((enable) {
      _btnLoginSubject.add(enable);
    });

    // re check
    Rx.combineLatest5(
      _registerUsernameSubject,
      _registerPassSubject,
      _registerFullNameSubject,
      _registerPhoneSubject,
      _registerEmailSubject,
      (username, pass, fname, phone, email) {
        return username.isNotEmpty &&
            pass.isNotEmpty &&
            fname.isNotEmpty &&
            phone.isNotEmpty &&
            email.isNotEmpty;
      },
    ).listen((enable) {
      _btnRegisterSubject.add(enable);
    });
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is StartEvent) {
      yield AuthInitState();
    } else if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedToState(event);
    } else if (event is RegisterButtonPressed) {
      yield* _mapRegisterButtonPressedToState(event);
    }
  }

  Stream<AuthState> _mapLoginButtonPressedToState(
      LoginButtonPressed event) async* {
    yield LoginLoadingState();
    try {
      print("bloc login----------------" + event.password + event.username);
      // Call loginPressed method from repository
      final response = await _repo.loginUser(event.username, event.password);
      print("bloc login2----------------" + event.password + event.username);
      // Lưu token vào SharedPreferences
      await _saveToken(response.accessToken.toString());
      if (response.status == 200) {
        yield LoginSuccessState(token: response.accessToken.toString());
      }
      yield LoginErrorState(
          message: 'Failed to login' + response.message.toString());
    } catch (e) {
      yield const LoginErrorState(message: 'Failed to login');
    }
  }

  Stream<AuthState> _mapRegisterButtonPressedToState(
      RegisterButtonPressed event) async* {
    yield RegisterLoadingState();
    try {
      // Call registerUser method from repository
      final response = await _repo.registerUser(event.user);

      if (response.status == 200) {
        yield RegisterSuccessState(user: response.data!);
      } else {
        yield RegisterErrorState(
            message: response.message ?? 'Failed to register');
      }
    } catch (e) {
      yield const RegisterErrorState(message: 'Failed to register');
    }
  }

  // Phương thức để lưu token vào SharedPreferences
  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  var loginUsernameValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    sink.add(Validation.validateUsername(username));
  });

  var loginPassValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    sink.add(Validation.validatePassword(pass));
  });

  //---------------------------------
  var registerUsernameValidation =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (username, sink) {
    sink.add(Validation.validateUsername(username));
  });

  var registerPassValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    sink.add(Validation.validatePassword(pass));
  });

  var registerFullNameValidation =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (fullName, sink) {
    sink.add(Validation.validateFullName(fullName));
  });

  var registerPhoneValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    sink.add(Validation.validatePhone(phone));
  });

  var registerEmailValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    sink.add(Validation.validateEmail(email));
  });

  /**
 * LoginCheck
 */
  // Getters and setters for username, password, and btnLogin
  Stream<String> get loginUsernameStream =>
      _loginUsernameSubject.stream.transform(loginUsernameValidation);
  Sink<String> get loginUsernameSink => _loginUsernameSubject.sink;

  Stream<String> get loginPassStream =>
      _loginpassSubject.stream.transform(loginPassValidation);
  Sink<String> get loginPassSink => _loginpassSubject.sink;

  Stream<bool> get btnLoginStream => _btnLoginSubject.stream;
  Sink<bool> get btnLoginSink => _btnLoginSubject.sink;

  // Getters and setters for username, password, fullname, phone, email, and btnRegister
  Stream<String> get registerUsernameStream =>
      _registerUsernameSubject.stream.transform(registerUsernameValidation);
  Sink<String> get registerUsernameSink => _registerUsernameSubject.sink;

  Stream<String> get registerPassStream =>
      _registerPassSubject.stream.transform(registerPassValidation);
  Sink<String> get registerPassSink => _registerPassSubject.sink;

  Stream<String> get registerFullNameStream =>
      _registerFullNameSubject.stream.transform(registerFullNameValidation);
  Sink<String> get registerFullNameSink => _registerFullNameSubject.sink;

  Stream<String> get registerPhoneStream =>
      _registerPhoneSubject.stream.transform(registerPhoneValidation);
  Sink<String> get registerPhoneSink => _registerPhoneSubject.sink;

  Stream<String> get registerEmailStream =>
      _registerEmailSubject.stream.transform(registerEmailValidation);
  Sink<String> get registerEmailSink => _registerEmailSubject.sink;

  Stream<bool> get btnRegisterStream => _btnRegisterSubject.stream;
  Sink<bool> get btnRegisterSink => _btnRegisterSubject.sink;

  @override
  Future<void> close() {
    // login
    _loginUsernameSubject.close();
    _loginpassSubject.close();
    _btnLoginSubject.close();
    //register
    _registerUsernameSubject.close();
    _registerPassSubject.close();
    _registerFullNameSubject.close();
    _registerPhoneSubject.close();
    _registerEmailSubject.close();
    _btnLoginSubject.close();
    _btnRegisterSubject.close();
    return super.close();
  }
}
