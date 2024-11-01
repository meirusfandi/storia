import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_list_response.freezed.dart';
part 'story_list_response.g.dart';

@freezed
class StoryListResponse with _$StoryListResponse {
  const factory StoryListResponse(
      {bool? error,
      String? message,
      List<ResultStoryListResponse>? listStory}) = _StoryListResponse;

  factory StoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryListResponseFromJson(json);
}

@freezed
class ResultStoryListResponse with _$ResultStoryListResponse {
  const factory ResultStoryListResponse(
      {String? id,
      String? name,
      String? description,
      String? photoUrl,
      String? createdAt,
      double? lat,
      double? lon}) = _ResultStoryListResponse;

  factory ResultStoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$ResultStoryListResponseFromJson(json);
}
