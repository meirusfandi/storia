part of '../bloc/login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class DoLoginEvent extends LoginEvent {
  final String email;
  final String password;

  const DoLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class DoLogoutEvent extends LoginEvent {
  const DoLogoutEvent();

  @override
  List<Object?> get props => [];
}
