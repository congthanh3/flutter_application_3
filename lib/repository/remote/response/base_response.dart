// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  BaseResponse({
    @JsonKey(name: 'data') this.data,
    @JsonKey(name: 'status_code') this.statusCode,
    @JsonKey(name: 'status_code') this.statusMessage,
    @JsonKey(name: 'success') this.success,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);

  final T? data;
  final int? statusCode;
  final String? statusMessage;
  final bool? success;
}
