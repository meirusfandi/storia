part of '../bloc/form_story_bloc.dart';

class FormStoryState extends Equatable {
  final String errorMessage;
  final bool isLoading;
  final AddStoryEntity? addStoryEntity;

  const FormStoryState(
      {this.errorMessage = '', this.isLoading = false, this.addStoryEntity});

  const FormStoryState.noValue()
      : errorMessage = '',
        isLoading = true,
        addStoryEntity = null;

  FormStoryState copyWith(
      {bool? isLoading, String? errorMessage, AddStoryEntity? addStoryEntity}) {
    return FormStoryState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        addStoryEntity: addStoryEntity ?? this.addStoryEntity);
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, addStoryEntity];
}
