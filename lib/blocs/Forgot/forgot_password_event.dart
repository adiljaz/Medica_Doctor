part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent {}

class ForgotClickEvent extends ForgotPasswordEvent{
  final String email;
  ForgotClickEvent(this.email);
}
