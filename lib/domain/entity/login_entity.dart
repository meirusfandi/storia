import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_entity.freezed.dart';
part 'login_entity.g.dart';

@freezed
class LoginEntity with _$LoginEntity {
  const factory LoginEntity(
      {required bool error,
      required String message,
      required ResultLoginEntity loginResult}) = _LoginEntity;

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);
}

@freezed
class ResultLoginEntity with _$ResultLoginEntity {
  const factory ResultLoginEntity({
    required String userId,
    required String name,
    required String token,
  }) = _ResultLoginEntity;

  factory ResultLoginEntity.fromJson(Map<String, dynamic> json) =>
      _$ResultLoginEntityFromJson(json);
}
