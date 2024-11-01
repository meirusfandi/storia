part of '../bloc/login_bloc.dart';

class LoginState extends Equatable {
  final String errorMessage;
  final bool isLoading;
  final bool? isLogout;
  final LoginEntity? loginEntity;

  const LoginState(
      {this.errorMessage = '',
      this.isLoading = false,
      this.loginEntity,
      this.isLogout});

  const LoginState.noValue()
      : errorMessage = '',
        isLoading = true,
        isLogout = true,
        loginEntity = null;

  const LoginState.logoutNoValue()
      : errorMessage = '',
        isLoading = true,
        isLogout = false,
        loginEntity = null;

  LoginState copyWith(
      {bool? isLoading,
      bool? isLogout,
      String? errorMessage,
      LoginEntity? loginEntity}) {
    return LoginState(
        isLoading: isLoading ?? this.isLoading,
        isLogout: isLogout ?? this.isLogout,
        errorMessage: errorMessage ?? this.errorMessage,
        loginEntity: loginEntity ?? this.loginEntity);
  }

  @override
  List<Object?> get props => [isLoading, isLogout, errorMessage, loginEntity];
}
