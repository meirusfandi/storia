part of '../bloc/story_detail_bloc.dart';

class StoryDetailEvent extends Equatable {
  const StoryDetailEvent();

  @override
  List<Object?> get props => [];
}

class DetailEvent extends StoryDetailEvent {
  final String storyId;

  const DetailEvent({required this.storyId});

  @override
  List<Object?> get props => [storyId];
}
