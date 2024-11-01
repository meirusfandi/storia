import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_story_entity.freezed.dart';
part 'add_story_entity.g.dart';

@freezed
class AddStoryEntity with _$AddStoryEntity {
  const factory AddStoryEntity({required bool error, required String message}) =
      _AddStoryEntity;

  factory AddStoryEntity.fromJson(Map<String, dynamic> json) =>
      _$AddStoryEntityFromJson(json);
}
