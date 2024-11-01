import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_list_entity.freezed.dart';
part 'story_list_entity.g.dart';

@freezed
class StoryListEntity with _$StoryListEntity {
  const factory StoryListEntity(
      {required bool error,
      required String message,
      required List<ResultStoryListEntity> listStory}) = _StoryListEntity;

  factory StoryListEntity.fromJson(Map<String, dynamic> json) =>
      _$StoryListEntityFromJson(json);
}

@freezed
class ResultStoryListEntity with _$ResultStoryListEntity {
  const factory ResultStoryListEntity(
      {required String id,
      required String name,
      required String description,
      required String photoUrl,
      required String createdAt,
      required double lat,
      required double lon}) = _ResultStoryListEntity;

  factory ResultStoryListEntity.fromJson(Map<String, dynamic> json) =>
      _$ResultStoryListEntityFromJson(json);
}
