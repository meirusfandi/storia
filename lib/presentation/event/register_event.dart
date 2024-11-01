part of '../bloc/register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class DoRegisterEvent extends RegisterEvent {
  final String email;
  final String name;
  final String password;

  const DoRegisterEvent(
      {required this.email, required this.password, required this.name});

  @override
  List<Object?> get props => [email, password, name];
}
