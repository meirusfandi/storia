import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storia/data/model/response/story_list_response.dart';

part 'story_detail_response.freezed.dart';
part 'story_detail_response.g.dart';

@freezed
class StoryDetailResponse with _$StoryDetailResponse {
  const factory StoryDetailResponse(
      {bool? error,
      String? message,
      ResultStoryListResponse? story}) = _StoryDetailResponse;

  factory StoryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailResponseFromJson(json);
}
