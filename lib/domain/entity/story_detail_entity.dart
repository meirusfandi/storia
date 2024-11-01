import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storia/domain/entity/story_list_entity.dart';

part 'story_detail_entity.freezed.dart';
part 'story_detail_entity.g.dart';

@freezed
class StoryDetailEntity with _$StoryDetailEntity {
  const factory StoryDetailEntity(
      {required bool error,
      required String message,
      required ResultStoryListEntity story}) = _StoryDetailEntity;

  factory StoryDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailEntityFromJson(json);
}
