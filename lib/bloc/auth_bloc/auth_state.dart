import 'package:equatable/equatable.dart';
import 'package:flutter_app_hotel_management/data/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

//--------------------Login----------------------
class LoginInitState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String token;

  const LoginSuccessState({required this.token});

  @override
  List<Object> get props => [token];
}

class LoginErrorState extends AuthState {
  final String message;

  const LoginErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

//--------------------Register----------------------
class RegisterInitState extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final UserModel user;

  const RegisterSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterErrorState extends AuthState {
  final String message;

  const RegisterErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
