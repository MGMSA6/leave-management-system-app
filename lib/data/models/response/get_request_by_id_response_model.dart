import 'package:equatable/equatable.dart';
import 'response_model.dart';
import 'meta_model.dart';

class GetRequestByIdResponseModel extends Equatable {
  final String status;
  final String statusCode;
  final String statusDesc;
  final ResponseModel data;
  final MetaModel? meta;

  const GetRequestByIdResponseModel({
    required this.status,
    required this.statusCode,
    required this.statusDesc,
    required this.data,
    this.meta,
  });

  factory GetRequestByIdResponseModel.fromJson(Map<String, dynamic> json) {
    return GetRequestByIdResponseModel(
      status: json['status'] as String,
      statusCode: json['statusCode'] as String,
      statusDesc: json['statusDesc'] as String? ?? '',
      data: ResponseModel.fromJson(json['data'] as Map<String, dynamic>),
      meta: json['meta'] != null && json['meta'] is Map<String, dynamic>
          ? MetaModel.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [status, statusCode, statusDesc, data, meta];
}
