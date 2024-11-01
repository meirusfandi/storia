part of '../bloc/form_story_bloc.dart';

class FormStoryEvent extends Equatable {
  const FormStoryEvent();

  @override
  List<Object?> get props => [];
}

class FormEvent extends FormStoryEvent {
  final String description;
  final String photo;
  final double lat;
  final double lon;

  const FormEvent(
      {required this.description,
      required this.photo,
      required this.lat,
      required this.lon});

  @override
  List<Object?> get props => [description, photo, lat, lon];
}
