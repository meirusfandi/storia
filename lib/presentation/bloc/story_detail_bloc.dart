import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/domain/entity/story_detail_entity.dart';
import 'package:storia/domain/usecase/get_detail_story.dart';

part '../event/story_detail_event.dart';
part '../state/story_detail_state.dart';

class StoryDetailBloc extends Bloc<StoryDetailEvent, StoryDetailState> {
  final GetDetailStory getDetailStory;
  StoryDetailBloc({required this.getDetailStory})
      : super(const StoryDetailState()) {
    on<DetailEvent>(_getDetailStory);
  }

  Future<void> _getDetailStory(
      DetailEvent event, Emitter<StoryDetailState> emit) async {
    try {
      emit(const StoryDetailState.noValue());
      final result =
          await getDetailStory(DetailStoryParams(storyId: event.storyId));
      result.fold((l) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage:
              (l as StoryFailure).exception?.response?.data['message'],
        ));
      }, (r) {
        emit(state.copyWith(isLoading: false, detailEntity: r));
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
