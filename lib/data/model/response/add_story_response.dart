import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_story_response.freezed.dart';
part 'add_story_response.g.dart';

@freezed
class AddStoryResponse with _$AddStoryResponse {
  const factory AddStoryResponse({bool? error, String? message}) =
      _AddStoryResponse;

  factory AddStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AddStoryResponseFromJson(json);
}
