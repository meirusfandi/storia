import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_story_request.freezed.dart';
part 'add_story_request.g.dart';

@freezed
class AddStoryRequest with _$AddStoryRequest {
  const factory AddStoryRequest(
      {required String description,
      required String photo,
      required double lat,
      required double lon}) = _AddStoryRequest;

  factory AddStoryRequest.fromJson(Map<String, dynamic> json) =>
      _$AddStoryRequestFromJson(json);
}
