import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.freezed.dart';

@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    bool? success,
    int? code,
    String? message,
    String? messageCode,
    DataErrorResponse? data,
  }) = _ErrorResponse;
}

@freezed
class DataErrorResponse with _$DataErrorResponse {
  const factory DataErrorResponse({
    String? id,
    String? en,
  }) = _DataErrorResponse;
}
