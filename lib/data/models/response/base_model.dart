import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'meta_model.dart';

part 'base_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseModel<T> extends Equatable {
  final String status;
  final String statusCode;
  final String statusDesc;
  final T? data;
  final MetaModel? meta;

  const BaseModel({
    required this.status,
    required this.statusCode,
    required this.statusDesc,
    required this.data,
    required this.meta,
  });

  /// Note: fromJsonT now takes `dynamic`, not `Map<String,dynamic>`
  factory BaseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return BaseModel(
      status: json['status'] as String,
      statusCode: json['statusCode'] as String,
      statusDesc: json['statusDesc'] as String,
      data: fromJsonT(json['data']),
      meta: json['meta'] != null && json['meta'] is Map<String, dynamic>
          ? MetaModel.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [status, statusCode, statusDesc, data, meta];
}
