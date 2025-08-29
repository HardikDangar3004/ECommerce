import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthAction extends Equatable {
  const AuthAction();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthAction {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginSuccess extends AuthAction {
  final User user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends AuthAction {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class SignupRequested extends AuthAction {
  final String email;
  final String password;
  final String? firstName;
  final String? lastName;

  const SignupRequested({
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
  });

  @override
  List<Object?> get props => [email, password, firstName, lastName];
}

class SignupSuccess extends AuthAction {
  final User user;

  const SignupSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SignupFailure extends AuthAction {
  final String error;

  const SignupFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class LogoutRequested extends AuthAction {}

class AuthStateChanged extends AuthAction {
  final User? user;

  const AuthStateChanged(this.user);

  @override
  List<Object?> get props => [user];
}

class ClearError extends AuthAction {}
