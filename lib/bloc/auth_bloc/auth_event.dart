import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends AuthEvent {}

//-----------------Login--------------------
class LoginButtonPressed extends AuthEvent {
  final String username;
  final String password;

  const LoginButtonPressed({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

//-----------------Login--------------------
class RegisterButtonPressed extends AuthEvent {
  final UserModel user;

  const RegisterButtonPressed({required this.user});
}
