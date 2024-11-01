import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/domain/entity/add_story_entity.dart';
import 'package:storia/domain/usecase/do_submit_story.dart';

part '../event/form_story_event.dart';
part '../state/form_story_state.dart';

class FormStoryBloc extends Bloc<FormStoryEvent, FormStoryState> {
  final DoSubmitStory doSubmitStory;
  FormStoryBloc({required this.doSubmitStory}) : super(const FormStoryState()) {
    on<FormEvent>(_doSubmitStory);
  }

  Future<void> _doSubmitStory(
      FormEvent event, Emitter<FormStoryState> emit) async {
    try {
      emit(const FormStoryState.noValue());
      final result = await doSubmitStory(SubmitStoryParams(
          description: event.description,
          photo: event.photo,
          lat: event.lat,
          lon: event.lon));
      result.fold((l) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage:
              (l as FormStoryFailure).exception?.response?.data['message'],
        ));
      }, (r) {
        emit(state.copyWith(isLoading: false, addStoryEntity: r));
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
