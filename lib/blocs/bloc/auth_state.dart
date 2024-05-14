// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState{}


final class Authenticated extends AuthState{
 User ?user;

 Authenticated (this.user);

}


final class Unauthenticated extends AuthState{}

class AuthError extends AuthState{
  final String error;

  AuthError({required this.error});
}


