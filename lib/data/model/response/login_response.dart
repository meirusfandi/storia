import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse(
      {bool? error,
      String? message,
      ResultLoginResponse? loginResult}) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
class ResultLoginResponse with _$ResultLoginResponse {
  const factory ResultLoginResponse({
    String? userId,
    String? name,
    String? token,
  }) = _ResultLoginResponse;

  factory ResultLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$ResultLoginResponseFromJson(json);
}
