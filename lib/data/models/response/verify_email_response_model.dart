import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_email_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VerifyEmailResponseModel extends Equatable {
  final String token;
  final String message;
  final bool success;

  const VerifyEmailResponseModel(
      {required this.token, required this.message, required this.success});

  factory VerifyEmailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailResponseModelToJson(this);

  @override
  List<Object?> get props => [token, message, success];
}
