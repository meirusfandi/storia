import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/domain/entity/register_entity.dart';
import 'package:storia/domain/usecase/do_register.dart';

part '../event/register_event.dart';
part '../state/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final DoRegister doRegister;
  RegisterBloc({required this.doRegister}) : super(const RegisterState()) {
    on<DoRegisterEvent>(_doRegister);
  }

  Future<void> _doRegister(
      DoRegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(const RegisterState.noValue());
      final result = await doRegister(RegisterParams(
          name: event.name, email: event.email, password: event.password));
      result.fold((l) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage:
              (l as RegisterFailure).exception?.response?.data['message'],
        ));
      }, (r) {
        emit(state.copyWith(isLoading: false, registerEntity: r));
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
