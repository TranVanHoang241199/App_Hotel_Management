import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_model.dart';
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
    print(" vaof map-----------");
    if (event is StartEvent) {
      yield AuthInitState();
    } else if (event is LoginButtonPressed) {
      print(" vaof map-----------" + event.username + "/" + event.password);

      yield* _mapLoginButtonPressedToState(event);
    } else if (event is RegisterButtonPressed) {
      yield* _mapRegisterButtonPressedToState(event);
    }
  }

  Stream<AuthState> _mapLoginButtonPressedToState(
      LoginButtonPressed event) async* {
    yield LoginLoadingState();
    try {
      print(" vaof maploin-----------" + event.username + "/" + event.password);
      // Call loginPressed method from repository
      final token = await _repo.loginUser(event.username, event.password);
      print(" vaof maploin-----------" + token.message.toString());
      // Lưu token vào SharedPreferences
      await _saveToken(token.accessToken.toString());
      if (token.status == 200) {
        yield LoginSuccessState(token: token.accessToken.toString());
      }
      yield LoginErrorState(
          message: 'Failed to login' + token.message.toString());
    } catch (e) {
      yield LoginErrorState(message: 'Failed to login');
    }
  }

  Stream<AuthState> _mapRegisterButtonPressedToState(
      RegisterButtonPressed event) async* {
    yield RegisterLoadingState();
    try {
      // Call registerUser method from repository
      final ApiResponse<UserModel> response =
          await _repo.registerUser(event.user);

      if (response.data != null) {
        yield RegisterSuccessState(user: response.data!);
      } else {
        yield RegisterErrorState(
            message: response.message ?? 'Failed to register');
      }
    } catch (e) {
      yield RegisterErrorState(message: 'Failed to register');
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

/**
 * sdfsdfsd
 */
class RegisterBlocCheck {
  final _usernameSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _fullNameSubject = BehaviorSubject<String>();
  final _phoneSubject = BehaviorSubject<String>();
  final _emailSubject = BehaviorSubject<String>();
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
    sink.add(Validation.validateFullName(fullName));
  });

  var phoneValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    sink.add(Validation.validatePhone(phone));
  });

  var emailValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    sink.add(Validation.validateEmail(email));
  });

  Stream<String> get usernameStream =>
      _usernameSubject.stream.transform(usernameValidation);
  Sink<String> get usernameSink => _usernameSubject.sink;

  Stream<String> get passStream =>
      _passSubject.stream.transform(passValidation);
  Sink<String> get passSink => _passSubject.sink;

  Stream<String> get fullNameStream =>
      _fullNameSubject.stream.transform(fullNameValidation);
  Sink<String> get fullNameSink => _fullNameSubject.sink;

  Stream<String> get phoneStream =>
      _phoneSubject.stream.transform(phoneValidation);
  Sink<String> get phoneSink => _phoneSubject.sink;

  Stream<String> get emailStream =>
      _emailSubject.stream.transform(emailValidation);
  Sink<String> get emailSink => _emailSubject.sink;

  Stream<bool> get btnRegisterStream => _btnRegisterSubject.stream;
  Sink<bool> get btnRegisterSink => _btnRegisterSubject.sink;

  RegisterBlocCheck() {
    Rx.combineLatest5(
      _usernameSubject,
      _passSubject,
      _fullNameSubject,
      _phoneSubject,
      _emailSubject,
      (username, pass, fname, phone, email) {
        return Validation.validateUsername(username) == '' &&
            Validation.validatePassword(pass) == '' &&
            Validation.validateFullName(fname) == '' &&
            Validation.validatePhone(phone) == '' &&
            Validation.validateEmail(email) == '';
      },
    ).listen((enable) {
      btnRegisterSink.add(enable);
    });
  }

  void dispose() {
    _usernameSubject.close();
    _passSubject.close();
    _fullNameSubject.close();
    _phoneSubject.close();
    _emailSubject.close();
    _btnRegisterSubject.close();
  }
}
