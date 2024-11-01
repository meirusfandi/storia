import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/failure/failure.dart';
import 'package:storia/domain/entity/story_list_entity.dart';
import 'package:storia/domain/usecase/get_list_story.dart';

part '../event/story_list_event.dart';
part '../state/story_list_state.dart';

class StoryListBloc extends Bloc<StoryListEvent, StoryListState> {
  final GetListStory getListStory;
  StoryListBloc({required this.getListStory}) : super(const StoryListState()) {
    on<ListEvent>(_doLogin);
  }

  Future<void> _doLogin(ListEvent event, Emitter<StoryListState> emit) async {
    try {
      emit(const StoryListState.noValue());
      final result = await getListStory(StoryParams(
          page: event.page, size: event.size, location: event.location));
      result.fold((l) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage:
              (l as StoryFailure).exception?.response?.data['message'],
        ));
      }, (r) {
        emit(state.copyWith(isLoading: false, listEntity: r));
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
