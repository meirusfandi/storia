import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/core/helper/pref_helpers.dart';
import 'package:storia/core/helper/pref_key.dart';
import 'package:storia/domain/entity/login_entity.dart';
import 'package:storia/domain/usecase/do_login.dart';

part '../event/login_event.dart';
part '../state/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DoLogin doLogin;
  LoginBloc({required this.doLogin}) : super(const LoginState()) {
    on<DoLoginEvent>(_doLogin);
    on<DoLogoutEvent>(_doLogout);
  }

  Future<void> _doLogin(DoLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(const LoginState.noValue());
      final result = await doLogin(
          LoginParams(email: event.email, password: event.password));
      result.fold((l) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage:
              (l as LoginFailure).exception?.response?.data['message'],
        ));
      }, (r) {
        prefInstance.setString(PrefKey.token.name, r.loginResult.token);
        prefInstance.setString(PrefKey.userId.name, r.loginResult.userId);
        prefInstance.setString(PrefKey.userName.name, r.loginResult.name);
        emit(state.copyWith(isLoading: false, loginEntity: r));
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _doLogout(DoLogoutEvent event, Emitter<LoginState> emit) async {
    try {
      emit(const LoginState.logoutNoValue());
      prefHelpers.clearData;
      emit(state.copyWith(isLoading: false, isLogout: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isLogout: false));
    }
  }
}
