part of '../bloc/register_bloc.dart';

class RegisterState extends Equatable {
  final String errorMessage;
  final bool isLoading;
  final RegisterEntity? registerEntity;

  const RegisterState(
      {this.errorMessage = '', this.isLoading = false, this.registerEntity});

  const RegisterState.noValue()
      : errorMessage = '',
        isLoading = true,
        registerEntity = null;

  RegisterState copyWith(
      {bool? isLoading, String? errorMessage, RegisterEntity? registerEntity}) {
    return RegisterState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        registerEntity: registerEntity ?? this.registerEntity);
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, registerEntity];
}
