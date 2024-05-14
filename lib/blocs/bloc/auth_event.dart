part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
// login
class CheckLoginStatusEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

// sighn up

class SighnupEvent extends AuthEvent{
  final UserModel user;

  SighnupEvent({required this.user});
}

class LogoutEvent extends AuthEvent{}
