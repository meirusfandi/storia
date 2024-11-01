part of '../bloc/story_list_bloc.dart';

class StoryListState extends Equatable {
  final String errorMessage;
  final bool isLoading;
  final StoryListEntity? listEntity;

  const StoryListState(
      {this.errorMessage = '', this.isLoading = false, this.listEntity});

  const StoryListState.noValue()
      : errorMessage = '',
        isLoading = true,
        listEntity = null;

  StoryListState copyWith(
      {bool? isLoading, String? errorMessage, StoryListEntity? listEntity}) {
    return StoryListState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        listEntity: listEntity ?? this.listEntity);
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, listEntity];
}
