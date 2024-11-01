part of '../bloc/story_list_bloc.dart';

class StoryListEvent extends Equatable {
  const StoryListEvent();

  @override
  List<Object?> get props => [];
}

class ListEvent extends StoryListEvent {
  final int page;
  final int size;
  final int location;

  const ListEvent(
      {required this.page, required this.size, required this.location});

  @override
  List<Object?> get props => [page, size, location];
}

class ListMoreEvent extends StoryListEvent {
  final int page;
  final int size;
  final int location;

  const ListMoreEvent(
      {required this.page, required this.size, required this.location});

  @override
  List<Object?> get props => [page, size, location];
}
