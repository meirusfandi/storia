part of '../bloc/story_detail_bloc.dart';

class StoryDetailState extends Equatable {
  final String errorMessage;
  final bool isLoading;
  final StoryDetailEntity? detailEntity;

  const StoryDetailState(
      {this.errorMessage = '', this.isLoading = false, this.detailEntity});

  const StoryDetailState.noValue()
      : errorMessage = '',
        isLoading = true,
        detailEntity = null;

  StoryDetailState copyWith(
      {bool? isLoading,
      String? errorMessage,
      StoryDetailEntity? detailEntity}) {
    return StoryDetailState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        detailEntity: detailEntity ?? this.detailEntity);
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, detailEntity];
}
