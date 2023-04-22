import 'package:meta/meta.dart';

@sealed
class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String msg;

  LoginError(this.msg);
}