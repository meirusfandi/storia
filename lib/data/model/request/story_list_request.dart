import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_list_request.freezed.dart';
part 'story_list_request.g.dart';

@freezed
class StoryListRequest with _$StoryListRequest {
  const factory StoryListRequest(
      {required int page,
      required int size,
      required int location}) = _StoryListRequest;

  factory StoryListRequest.fromJson(Map<String, dynamic> json) =>
      _$StoryListRequestFromJson(json);
}
