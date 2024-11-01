import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_entity.freezed.dart';
part 'register_entity.g.dart';

@freezed
class RegisterEntity with _$RegisterEntity {
  const factory RegisterEntity({required bool error, required String message}) =
      _RegisterEntity;

  factory RegisterEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterEntityFromJson(json);
}
