part of '../bloc/story_list_bloc.dart';

class StoryListState extends Equatable {
  final String errorMessage;
  final bool isLoading;
  final bool isLoadingMore;
  final StoryListEntity? listEntity;

  const StoryListState(
      {this.errorMessage = '', this.isLoadingMore = false, this.isLoading = false, this.listEntity});

  const StoryListState.noValue()
      : errorMessage = '',
        isLoading = true,
        isLoadingMore = false,
        listEntity = null;

  StoryListState copyWith(
      {bool? isLoading, bool? isLoadingMore, String? errorMessage, StoryListEntity? listEntity}) {
    return StoryListState(
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        errorMessage: errorMessage ?? this.errorMessage,
        listEntity: listEntity ?? this.listEntity);
  }

  @override
  List<Object?> get props => [isLoading, isLoadingMore, errorMessage, listEntity];
}
