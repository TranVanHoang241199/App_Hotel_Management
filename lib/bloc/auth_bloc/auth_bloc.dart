import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_model.dart';
import '../../data/repositorys/auth_repository.dart';
import '../../utils/validation.dart';
import '../auth_bloc/auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository repo;

  AuthBloc(AuthState initialState, this.repo) : super(LoginInitState()) {
    on<LoginButtonPressed>((event, emit) async {
      await loginPressed(event.username, event.password, emit);
    });

    on<RegisterButtonPressed>(
      (event, emit) async {
        await registerPressed(event.user, emit);
      },
    );
  }

  Future<void> loginPressed(
      String username, String password, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());

    try {
      if (username.isEmpty || password.isEmpty) {
        emit(const LoginErrorState(
            message: 'Username and password cannot be empty'));
        return;
      }

      final token = await repo.loginUser(username, password);

      if (token.accessToken != null) {
        emit(LoginSuccessState(token: token.accessToken!));

        // Set token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', token.accessToken.toString());
      } else {
        emit(const LoginErrorState(message: 'Access token is null'));
      }
    } catch (e) {
      emit(const LoginErrorState(message: 'Failed to login'));
    }
  }

  Future<void> registerPressed(UserModel user, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());
    try {
      final data = await repo.registerUser(user);

      if (data.data != null) {
        emit(RegisterSuccessState(user: data.data!));
      } else {
        emit(const RegisterErrorState(message: 'Failed to register'));
      }
    } catch (e) {
      emit(const RegisterErrorState(message: 'Failed to register'));
    }
  }

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // Bạn có thể sử dụng mapEventToState để xử lý các sự kiện khác nếu cần
    if (event is StartEvent) {
      yield LoginInitState();
    }
  }
}

/**
 * LoginCheck
 */
class LoginBlocCheck {
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

  LoginBlocCheck() {
    Rx.combineLatest2(_usernameSubject, _passSubject, (username, pass) {
      return Validation.validateUsername(username) == '' &&
          Validation.validatePassword(pass) == '';
    }).listen((enable) {
      btnLoginSink.add(enable);
    });
  }

  void dispose() {
    _usernameSubject.close();
    _passSubject.close();
    _btnLoginSubject.close();
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
            Validation.validatePassword(fname) == '' &&
            Validation.validatePassword(phone) == '' &&
            Validation.validatePassword(email) == '';
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
